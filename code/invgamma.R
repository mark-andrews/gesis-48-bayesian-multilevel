dinvgamma <- function(x, shape, scale){
  # Density of Inverse gamma distribution.
  
  lgdensity <- shape*log(scale) - lgamma(shape) + (-shape-1)*log(x) - scale/x
  
  return(exp(lgdensity))
  
}

dinvchisq <- function(x, nu, tau){
  # Density of scaled inverse chi sq.
  # Degrees of freedom = nu
  # scale = tau^2
  
  invgamma.shape <- nu/2
  invgamma.scale <- nu/2 * tau^2
  
  return(dinvgamma(x, shape=invgamma.shape, scale=invgamma.scale))
  
}

dnorminvchisq <- function(mu, sigma, mu.n, kappa.n, nu.n, sigmasq.n){
  # Normal x scaled inverse chi sq distribution
  # Nnnormalized density of mu, sigma
  # given mu.n, kappa.n, nu.n, sigmasq.n
  
  f <- (sigma^(-3) 
        * (sigma^2)^(-nu.n/2) 
        *  exp(-1/(2*sigma^2) * ( nu.n * sigmasq.n + kappa.n*(mu.n - mu)^2))
  )
  
  return(f)
  
}