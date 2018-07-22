## Put comments here that give an overall description of what your
## functions do

#makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse#
## Write a short comment describing this function
## empty matrix is first initialised to store the cache

makeCacheMatrix <- function(x = matrix()) {
  ## Initialize the inverse matrix , this is where the inverse matrix will be stored.
  i <- NULL
  ## Method to set the matrix
  set <- function(matrix) {
    m <<- matrix
    i <<- NULL
  }
  ## Method the get the matrix
  get <- function() {
    ## Return the matrix
    m
  }

  ## Method to set the inverse of the matrix
  setInverse <- function(inverse) {
    i <<- inverse
  }
  ## Method to get the inverse of the matrix
  getInverse <- function() {
    ## Return the inverse property
    i
  }
  ## Return a list of the methods
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}
test <-makeCacheMatrix(matrix(1))

## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  
  ## Return a matrix that is the inverse of 'x'
  m <- x$getInverse()
  
  ## Just return the inverse if its already set
  if( !is.null(m) ) {
    message("getting cached data")
    return(m)
  }
  
  ## Get the matrix from our object
  data <- x$get()
  
  ## Calculate the inverse using matrix multiplication
  m <- solve(data) %*% data
  
  ## Set the inverse to the object
  x$setInverse(m)
  
  ## Return the matrix
  m
}

