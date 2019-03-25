dstudent <- function(x, nu, mu, sigma.sq){
  sigma <- sqrt(sigma.sq)
  logf <- lgamma((nu+1)/2) - lgamma(nu/2) - log(sqrt(nu*pi)*sigma) -((nu+1)/2)*log(
            1 + 1/nu*((x-mu)/sigma)^2)
  return(exp(logf))
}

# Posterior
curve(dstudent(x, nu.n, mu.n, sigmasq.n/kappa.n), 
      xlab='x',
      ylab='P(x)',
      from=2.5, 
      to=5.5, 
      n=1001)

# Posterior predictive
x <- seq(-10, 10, by=0.1)
curve(dstudent(x, nu.n, mu.n, sigmasq.n*(1 + 1/kappa.n)), 
      xlab='x',
      ylab='P(x|D)',
      from=-2, 
      to=10, 
      n=1001)