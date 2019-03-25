chisq.df <- 5

proposal <- function(center){
  r <- rnorm(1, mean=center, sd = 1)
  return(max(0, r))
}

density.f <- function(x){
  return(dchisq(x, df=chisq.df))
}

x <- runif(1, min=50, max=100)

X.samples <- c(x)
n.samples <- 1e4
counter <- 0

while (length(X.samples) < n.samples) {
  
  counter <- counter + 1
  
  candidate.x <- proposal(x)
  
  alpha <- density.f(candidate.x)/density.f(x)
  
  if (runif(1, min=0, max=1) < min(alpha, 1.0)) {x
    x <- candidate.x
    X.samples <- c(X.samples, x)
  }
  
}

sample.f <- function(n){
  return(rchisq(n, df=chisq.df))
}
par(mfrow=c(2,1))
hist(sample.f(n.samples/2), 100, xlim=c(0, qchisq(.999, df=chisq.df)))
hist(X.samples[(n.samples/2):n.samples], 100, xlim=c(0, qchisq(.999, df=chisq.df)))

