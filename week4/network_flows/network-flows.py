
# coding: utf-8

# ## Graph Creation
# 
# Let's begin by constructing the example graph from class.

# In[1]:

# initialize the directed graph
import networkx as nx
G = nx.DiGraph()

# add source and target nodes
G.add_node('s')
G.add_node('t')

# add edges -- automatically adds nodes
G.add_edge('u', 'v')
G.add_edges_from([('s', 'u'), ('s', 'v')])
G.add_edges_from([('u', 't'), ('v', 't')])


# The graph is small enough that we can draw it to make sure it's correct.

# In[2]:

# this "magic" is needed to draw graphs
get_ipython().magic(u'matplotlib inline')

# we need to explicitly state that we want to see node labels
# there are several ways to layout graphs, the 'circular' one
# gives a good result here
nx.draw_circular(G, with_labels=True, node_color='w', node_size=500)


# ## Max Flow
# 
# To complete the formulation of the max flow problem, we need to add the capacities.

# In[3]:

# add capacities to the edges
G.edge['s']['u']['capacity'] = 20
G.edge['s']['v']['capacity'] = 10
G.edge['u']['v']['capacity'] = 30
G.edge['u']['t']['capacity'] = 10
G.edge['v']['t']['capacity'] = 20


# We can now solve the max flow problem in just a single call.

# In[4]:

flow_value, maximum_flow = nx.maximum_flow(G, 's', 't')

# this gives a cleaner way to print out the flow
def print_flow(flow):
    for edge in G.edges():
        n1, n2 = edge
        print edge, flow[n1][n2]


print 'Flow value =', flow_value
print 'Flow ='
print_flow(maximum_flow)


# The maximum flow should equal the minimum cut.

# In[5]:

max_flow_value = nx.maximum_flow_value(G, 's', 't')
min_cut_value = nx.minimum_cut_value(G, 's', 't')

print max_flow_value == min_cut_value


# ## Flows with Demands
# 
# Let's now record a demand value at each node (negative demand corresponds to supply at a node).

# In[6]:

# to add a property to a node, you should use G.node['s'] rather than
# G['s'] to reference the node.

G.node['s']['demand'] = -25 
G.node['t']['demand'] = 20
G.node['u']['demand'] = 5
G.node['v']['demand'] = 0


# We'll create a copy of the graph to extend it and solve the flow-with-demands problem as a max-flow problem.

# In[7]:

# create deep copy of the graph
GD = G.copy()

# add new source and terminal nodes
GD.add_node('source')
GD.add_node('terminal')

# add edges of required capacity
for node in G.nodes():
    demand = G.node[node]['demand']
    if demand < 0:
        GD.add_edge('source', node)
        GD['source'][node]['capacity'] = -demand
    if demand > 0:
        GD.add_edge(node, 'terminal')
        GD[node]['terminal']['capacity'] = demand


# Let's draw this new graph to check that it's correct.

# In[8]:

nx.draw_circular(GD, with_labels=True, node_color='w', node_size=1000)


# Now we compute the max flow to obtain the flow with demands.

# In[9]:

flow_value, flow_with_demands = nx.maximum_flow(GD, 'source', 'terminal')

print 'Flow value =', flow_value
print 'Flow ='
print_flow(flow_with_demands)


# This is a valid solution, but it's not the same as the one we had in class!

# ## Min-Cost Flow
# 
# Let's now solve for the min-cost flow of the example we had in class. We have already added capacities and demands to our network. We finally need to introduce edge costs (weights).

# In[10]:

G.edge['s']['u']['weight'] = 1
G.edge['s']['v']['weight'] = 1
G.edge['u']['v']['weight'] = 1
G.edge['u']['t']['weight'] = 1
G.edge['v']['t']['weight'] = 2


# Now we can just call the min-cost flow function. Note that we could have used this to solve the flow-with-demands problem, just by setting all the costs (weights) to 0.

# In[11]:

minimum_cost_flow = nx.min_cost_flow(G)
print_flow(minimum_cost_flow)


# This is the same as the maximum flow found in class. For this example, the maximum flow is unique.

# ## Exercises
# 
# 1. Construct the bipartite graph from the example application in the slides and find a matching using max flow.
# 
# 2. Write a function to compute a conformal decomposition of a flow with demands, and run it on the flows found in the "Min-Cost Flow" section above.

# ### Solution 1
# 
# For the first problem, we form the network by hand then solve max flow using new source and sink vertices, imposing a capacity of 1 on all edges.

# In[12]:

B = nx.Graph()
# the nodes
B.add_nodes_from([1,2,3,4], right=0)
B.add_nodes_from('abcd', right=1)
# the edges
B.add_edges_from([(1, 'a'), (1, 'b'), (1,'c')])
B.add_edges_from([(2,'b'), (2,'d')])
B.add_edges_from([(3, 'b'), (3, 'c')])
B.add_edges_from([(4, 'c')])


# Let's first convert the graph to a directed graph. If we just use the digraph constructor, we get edges in both directions, so we need to remove edges from the right-hand side to left-hand side nodes.

# In[13]:

BD = nx.DiGraph(B)
for (u,v) in BD.edges():
    # check whether v is on the right-hand side
    if not BD.node[v]['right']:
        BD.remove_edge(u, v)


# Now add the source and target nodes, and link them to the current nodes.

# In[14]:

BD.add_node('source')
BD.add_node('terminal')
# we have to be careful to interate over nodes in B, not BD (i.e., we want to exclude source and target)
for n in B.nodes():
    if B.node[n]['right']:
        BD.add_edge(n, 'terminal')
    else:
        BD.add_edge('source', n)
    


# Finally, add a capacity of 1 to each edge, and solve the max flow problem.

# In[15]:

for (u,v) in BD.edges():
    BD.edge[u][v]['capacity'] = 1
flow_value, matching_flow = nx.maximum_flow(BD, 'source', 'terminal')


# We can now remove the source and target we introduced, and print out the matching.

# In[16]:

BD.remove_node('source')
BD.remove_node('terminal')

print 'Matching size =', flow_value
for (u,v) in BD.edges():
    if matching_flow[u][v] == 1:
        print (u,v) 


# ### Solution 2
# 
# The flow returned by the  <code>min_cost_flow</code>  function in NetworkX takes the form of a dict of dicts, yielding the flow over an edge (u,v) via <code>flow[u][v]</code>. We'll first introduce a function to re-create a network from the flow, omitting any edges with flow of 0.

# In[27]:

def create_network(flow):
    """ Creates a network from the given flow dict, omitting edges with flow of 0.
    
    Parameters
    ----------
    flow : dict
        the flows along each edge
        
    Returns
    -------
    network : DiGraph
        the network re-created from the edge flows, with flows recorded on edges
    """
    network = nx.DiGraph()
    edges = [(u,v) for u in flow.keys() for v in flow[u].keys()]
    for (u,v) in edges:
        if flow[u][v] > 0:
            network.add_edge(u,v)
            network.edge[u][v]['flow'] = flow[u][v]
    return network


# Next let's add a function that adds source and terminal nodes to the network, with the source connected to supply nodes, and the terminal connected to demand nodes. This is the standard transformation we used to go from a flow-with-demands problem to a max-flow problem. It is useful to define a helper function that identifies the supply and demand nodes from the flow.

# In[47]:

def divergence(network):
    """ Computes the divergence vector of the flow, meaning the net flow into each node (which may be negative).
    
    Parameters
    ----------
    network : DiGraph
        the network represented by the flow
        
    Returns
    -------
    div : dict
        the total flow into each node
    """
    for n in network.nodes():
        outflow = sum(network.edge[n][s]['flow'] for s in network.successors(n))
        inflow = sum(network.edge[p][n]['flow'] for p in network.predecessors(n))
        network.node[n]['demand'] = inflow - outflow
    div = {n : network.node[n]['demand'] for n in network.nodes()}
    return div

def extend_network(network):
    """ Adds a source node connected to all supply nodes, and a terminal node connected to all demand nodes.
    
    Parameters
    ----------
    network : DiGraph
        the network represented by the flow    
    """
    # first compute the demands at each node
    divergence(network)
    # now add edges to new source and terminal
    for n in network.nodes():
        demand = network.node[n]['demand']
        # check for supply node
        if demand < 0:
            network.add_edge('_source', n)
            network.edge['_source'][n]['flow'] = -demand
        # check for demand node
        if demand > 0:
            network.add_edge(n, '_terminal')
            network.edge[n]['_terminal']['flow'] = demand


# Now the process is to repeatedly find a path from the source to the terminal, find the minimum flow along the path, and remove that path flow. The decomposition continues until there is no longer a path from source to terminal, or in other words, from a supply node to a demand node. 

# In[58]:

def conformal_decomposition(flow):
    """ Computes a conformal decomposition of the given flow.
    
    Parameters
    ----------
    flow : dict
        the flows along each edge
        
    Returns
    -------
    decomposition : list
        a list of pairs consisting of paths and flow amounts, where paths are lists of nodes
    """
    # first create the network from the flow, then add source and terminal
    network = create_network(flow)
    extend_network(network)
    # repeat until there is no longer a path from source to terminal
    decomposition = []
    while True:
        # an exception is thrown when there is no path
        try:
            path = nx.shortest_path(network, source='_source', target='_terminal')
        except nx.NetworkXNoPath:
            break
        minflow = min(network.edge[path[i]][path[i+1]]['flow'] for i in range(len(path)-1))
        # remove source and terminal from the path description
        decomposition.append((path[1:-1], minflow))
        # subtract away the flow
        for i in range(len(path)-1):
            u, v = path[i], path[i+1]
            network.edge[u][v]['flow'] -= minflow
            if network.edge[u][v]['flow'] == 0:
                network.remove_edge(u, v)
    return decomposition
        


# We now have everything in place to compute a decomposition.

# In[62]:

decomposition = conformal_decomposition(minimum_cost_flow)
for (path, flow) in decomposition:
    print path, flow

