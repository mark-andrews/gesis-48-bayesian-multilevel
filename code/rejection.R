# Illustration of rejection sampling using beta distribution

shape1 <- 9.25
shape2 <- 3.5

rand.g <- function(){
  runif(1, min=0, max=1)
}

density.g <- function(x){
  return(1.0)
}

density.f <- function(x){
  return(dbeta(x, shape1=shape1, shape2=shape2))
}

x <- seq(0, 1, length.out=1000)
plot(x, density.f(x), type='l')

M <- dbeta(shape1/(shape1+shape2), 
           shape1=shape1, shape2=shape2)

n.samples <- 10000
X.samples <- c()
counter <- 0
while (length(X.samples) < n.samples){
  counter <- counter + 1
  x <- rand.g()
  u <- runif(1, min=0, max=1)
  if (u < density.f(x)/(M * density.g(x))) {
    X.samples <- c(X.samples, x)
  }
}