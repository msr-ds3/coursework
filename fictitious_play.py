# Download and install numpy from http://docs.scipy.org/doc/numpy/index.html
import numpy as np

### Matching pennies
n = 2
m = 2
A = np.matrix('1 -1; -1. 1.')
B = - A

# Running empirical average of the two players
# initialized for one player to play (1,1) strategy
# These are column vectors
x = np.zeros((n,1))
x[1,0] = 1
y = np.zeros((m,1))
y[1,0] = 1

# For 10000 iterations run fictitious play dynamics
for t in range(10000):
    # Calculate the utility of the row and column players
    # based on the current empirical play of opponent and
    # for each possible strategy
    
    # Find the maximum utility strategy for each player
    

    # Update the empirical estimates of each player
    
        
print(x)
print(y)

#### Rock paper scissors
n = 3
m = 3
A = np.matrix('0. -1. 1; 1. 0. -1.; -1 1 0')
B = - A

#### Modified Rock paper scissors
n = 3
m = 3
A = np.matrix('0. 1. 0.; 0. 0. 1.; 1. 0. 0.')
B = np.matrix('0. 0. 1.; 1. 0. 0.; 0. 1. 0.')

# Starting from (1,0,0) and (0,1,0) mixed strategy profile
x = np.zeros((n,1))
x[1,0] = 1
y = np.zeros((m,1))
y[2,0] = 1

#### Prisoners dilemma
n = 2
m = 2
A = np.matrix('.5 1.; 0. .2')
B = np.matrix('.5 0.; 1. .2')
T = 100
