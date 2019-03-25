# Normal likelihood

normal.likelihood <- function(mu, sigma, n, x.bar, s.sq){
  return(sigma^(-n) * exp(-1/(2*sigma^2) * (n*s.sq + n*(x.bar-mu)^2) ))
}

mu.lim <- seq(3, 5.3, by=0.05)
sigma.lim <- seq(0.5, 2.5, by=0.01)

L <- outer(mu.lim,
           sigma.lim,
           Vectorize( function(x, y){ normal.likelihood(mu=x,sigma=y, n=n, x.bar=x.bar, s.sq=s.sq)})
)

contour(mu.lim, 
        sigma.lim, 
        L,
        nlevels = 10,
        ylab=expression(sigma),
        xlab=expression(theta))
