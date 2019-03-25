#curve(dinvchisq(x, 5, 2), from=0.0, to=10.0, col='chocolate', n=n, xlab='x', ylab='P(x)')

 
mu.0 <- 0
kappa.0 <- 10
nu.0 <- 2
sigmasq.0 <- 2

prior <- function(x, y){
  return(dnorminvchisq(x, y, mu.n=mu.0, kappa.n=kappa.0, nu.n=nu.0, sigmasq.n=sigmasq.0))
}

mu.lim <- seq(3, 5.3, by=0.05)
sigma.lim <- seq(0.5, 2.5, by=0.01)

# 
Z <- outer(mu.lim,
           sigma.lim,
           Vectorize(
             function(x, y){
               return(dnorminvchisq(x, y, mu.n=mu.0, kappa.n=kappa.0, nu.n=nu.0, sigmasq.n=sigmasq.0))
             }
           )
           )
# 
# contour(mu.lim, 
#         sigma.lim, 
#         xlim=c(3.2, 5),
#         ylim=c(0.8, 2.1),
#         Z,
#         nlevels = 5,
#         ylab=expression(sigma),
#         xlab=expression(theta))
# 
# 
# f <- function(x, y) { x + y}
