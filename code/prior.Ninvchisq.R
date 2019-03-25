mu.0 <- 0
kappa.0 <- 0.1
nu.0 <- 2
sigmasq.0 <- 2

mu.lim <- seq(-10, 10, by=0.05)
sigma.lim <- seq(0.0, 5, by=0.01)

prior.f <- outer(mu.lim,
                 sigma.lim,
                 Vectorize(
                   function(x, y){
                     return(dnorminvchisq(x, y, mu.n=mu.0, kappa.n=kappa.0, nu.n=nu.0, sigmasq.n=sigmasq.0))
                   }
                 )
)

contour(mu.lim, 
        sigma.lim, 
        prior.f,
        nlevels = 20,
        ylab=expression(sigma),
        xlab=expression(theta))