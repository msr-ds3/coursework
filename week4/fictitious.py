import numpy as np

def fictitious(n,m,A,B,T,x0,y0):
    x = x0
    y = y0
    # For 10000 iterations run fictitious play dynamics
    for t in range(T):
        # Calculate the utility of the row and column players
        # based on the current empirical play of opponent and
        # for each possible strategy
        ur = A.dot(y)
        uc = x.transpose().dot(B)

        # Find the maximum utility strategy for each player
        it = ur.argmax()
        jt = uc.argmax()

        # Update the counts of each player
        x[it] += 1
        y[jt] += 1
    return (x/(T+1),y/(T+1))



#########################
### Matching pennies
#########################
n = 2
m = 2
A = np.matrix('1. -1.; -1. 1.')
B = - A
T = 1000
# Initial strategies of both players
x0 = np.zeros((n,1))
x0[1,0] = 1
y0 = np.zeros((m,1))
y0[1,0] = 1

# Run fictitious play algorithm
(x,y) = fictitious(n,m,A,B,T,x0,y0)

# Print results
print('Matching pennies')
print(x.transpose())
print(y.transpose())


#########################
#### Rock paper scissors
#########################
n = 3
m = 3
A = np.matrix('0. -1. 1; 1. 0. -1.; -1 1 0')
B = - A

# Initial strategies of both players
x0 = np.zeros((n,1))
x0[1,0] = 1
y0 = np.zeros((m,1))
y0[1,0] = 1

(x,y) = fictitious(n,m,A,B,T,x0,y0)

print('Rock-paper-scissors')
print(x.transpose())
print(y.transpose())

        
################################
## Modified Rock paper scissors
################################
n = 3
m = 3
A = np.matrix('0. 1. 0.; 0. 0. 1.; 1. 0. 0.')
B = np.matrix('0. 0. 1.; 1. 0. 0.; 0. 1. 0.')
T = 1000

# Running empirical average of the two players
# initialized for one player to play (1,1) strategy
# These are column vectors
x0 = np.zeros((n,1))
x0[1,0] = 1
y0 = np.zeros((m,1))
y0[2,0] = 1

(x,y) = fictitious(n,m,A,B,T,x0,y0)

print('Modified Rock Paper Scissors')  
print(x.transpose())
print(y.transpose())
        
    
#########################
## Prisoners dilemma
#########################
n = 2
m = 2
A = np.matrix('.5 1.; 0. .2')
B = np.matrix('.5 0.; 1. .2')
T = 100

# Running empirical average of the two players
# initialized for one player to play (1,1) strategy
# These are column vectors
x0 = np.zeros((n,1))
x0[1,0] = 1
y0 = np.zeros((m,1))
y0[1,0] = 1

(x,y) = fictitious(n,m,A,B,T,x0,y0)

print('Prisoner\'s Dilemma')
print(x.transpose())
print(y.transpose())

