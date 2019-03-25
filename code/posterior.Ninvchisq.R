mu.0 <- 0
kappa.0 <- 0.1
nu.0 <- 2
sigmasq.0 <- 2

kappa.n <- kappa.0 + n
mu.n = (kappa.0 * mu.0 + n*x.bar)/kappa.n
nu.n <- nu.0 + n
sigmasq.n <- 1/nu.n * ( nu.0*sigmasq.0 + n*s.sq + (mu.0-x.bar)^2*n*kappa.0/(kappa.0 + n))

mu.lim <- seq(-5, 5.5, by=0.05)
sigma.lim <- seq(.5, 2.5, by=0.01)

posterior.f <- outer(mu.lim,
                 sigma.lim,
                 Vectorize(
                   function(x, y){
                     return(dnorminvchisq(x, y, mu.n=mu.n, kappa.n=kappa.n, nu.n=nu.n, sigmasq.n=sigmasq.n))
                   }
                 )
)

contour(mu.lim, 
        sigma.lim, 
        posterior.f,
        nlevels = 20,
        ylab=expression(sigma),
        xlab=expression(theta))