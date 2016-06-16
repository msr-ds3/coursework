# list all student names
students <- dir('../students')
students <- tolower(gsub('.txt','', students))

# set the seed of the random number generator to number of days since 1970-01-01
seed <- as.numeric(Sys.Date())
set.seed(seed)

# shuffle student names
shuffled <- sample(students, length(students))

# convert shuffled vector to matrix of pairs
pairs <- matrix(shuffled, ncol=2, byrow=T)

print(pairs)
