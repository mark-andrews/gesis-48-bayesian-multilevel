x <- c(6, 8, 12, 7, 11, 14, 10, 12, 11, 16)

plot.gamma.distribution <- function(shape, scale, xlims=c(0, 50), add=F){
  
  curve(dgamma(x, shape=shape, scale=scale),
        from = xlims[1],
        to = xlims[2],
        xlab=expression(lambda),
        ylab=expression("P" * (lambda)),
        add=add,
        n=1001)
 
}

gamma.posterior <- function(x, prior.shape, prior.scale){
    S <- sum(x)
    n <- length(x)
    posterior.shape <- S + prior.shape
    posterior.scale <- 1/(n + 1/prior.scale)
    posterior.mean <- posterior.shape * posterior.scale
    posterior.variance <- posterior.shape * posterior.scale^2
    posterior.mode <- (posterior.shape - 1) * posterior.scale
    return(list(shape = posterior.shape,
                scale = posterior.scale,
                mean = posterior.mean,
                variance = posterior.variance,
                sd = sqrt(posterior.variance),
                mode = posterior.mode,
                S = S,
                n = n)
           )
}

gamma.hpd.interval <- function(kappa, theta){
  
  # This will break if either alpha < 1.0 or beta < 1.0
  # or alpha = beta = 1.0
  stopifnot(kappa > 1.0)
  
  # Too lazy to properly estimate upper bound,
  upper.bound = 100 
  
  interval.mass <- function(p.star){
    # Return the area under the curve for the 
    # set of points whose density >= p.star.
    
    f <- function(val){
      d <- dgamma(val, kappa, scale=theta)
      if (d >= p.star){
        return(d)
      }
      else {return(0)}
    }
    
    return(integrate(Vectorize(f), 0.0, upper.bound)$value)
    
  }
  
  err.fn <- function(p.star, hpd.mass=0.95){
    return((hpd.mass-interval.mass(p.star))^2)
  }
  
  max.f <- dgamma((kappa-1)*theta, kappa, scale=theta)
  
  Q <- optimize(err.fn, 
                interval = c(0, max.f)
  )
  
  precision <- 3
  p.star <- round(Q$minimum, precision)
  
  inside <- FALSE
  for (x in seq(0.0, upper.bound, by=10^(-precision-1))) {
    if (round(dgamma(x, kappa, scale=theta), precision) >= p.star) {
      if (inside){
        stop.interval <- x
      } else {
        start.interval <- x
        inside <- TRUE
      }
    } else
    {
      if (inside){
        inside <- FALSE
        interval <- c(start.interval, stop.interval)
      } 
    }
  }
  
  return(list(kappa = kappa,
              theta = theta,
              p.star = p.star, 
              hpd.interval=interval))
}


#####################################################################
# Posterior predictive distribution
posterior.predictive <- function(x, prior.shape=1, prior.scale=100.0){
  
  Posterior <- gamma.posterior(x, prior.shape = prior.shape, prior.scale = prior.scale)
  
  return(
    list(r = Posterior$S + prior.shape, # NegBinom: Predefined number of failures.
         q = 1/(Posterior$n + 1/prior.scale + 1) # NegBinom: Prob. of success.
         )
  )
}


#####################################################################
