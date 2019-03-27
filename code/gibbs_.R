# Illustration of Gibbs sampling using 2d Gaussians

library(MASS)
library(ellipse)

sigma.1 <- 1.25
sigma.2 <- 2.25

rho <- 0.75

Sigma <- matrix(rep(0, 4), 2, 2)
Sigma[1, 1] <- sigma.1 * sigma.1
Sigma[2, 2] <- sigma.2 * sigma.2
Sigma[1, 2] <- sigma.1 * sigma.2 * rho
Sigma[2, 1] <- Sigma[1, 2]

center <- c(2, 1)


conditional.dist <- function(center, Sigma, x.val=0.0, x.dim=2) {
  
  if (x.dim == 1) {
    d.0 = 2
  } else if (x.dim == 2) {
    d.0 = 1
  }
  
  s.11 <- Sigma[d.0, d.0]
  s.12 <- Sigma[d.0, x.dim]
  s.22 <- Sigma[x.dim, x.dim]

  mu <- center[d.0] + s.12/s.22 * (x.val - center[x.dim])
  var <- s.11 - s.12^2/s.22
  
  return(c(mu, var))
  
}

n.samples <- 1000
x <- c(0, 0)
X.samples <- c(x)
for (i in 1:n.samples) {
  
  params.1 <- conditional.dist(center, Sigma, x.val = x[2], x.dim=2)
  x[1] <- rnorm(1, mean=params.1[1], sd=sqrt(params.1[2]))
  
  params.2 <- conditional.dist(center, Sigma, x.val = x[1], x.dim=1)
  x[2] <- rnorm(1, mean=params.2[1], sd=sqrt(params.2[2]))
  
  X.samples <- rbind(X.samples, x)
}

y <- mvrnorm(1000, mu=center, Sigma=Sigma)

par(mfrow=c(2,1))
plot(ellipse(Sigma, centre = center), type='l', col='blue', xlab='x', ylab='y', xlim=c(-2, 6), ylim=c(-6, 8))
points(y)
plot(ellipse(Sigma, centre = center), type='l', col='blue', xlab='x', ylab='y', xlim=c(-2, 6), ylim=c(-6, 8))
points(X.samples)