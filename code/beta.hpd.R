alpha = 1.625
beta <- 3.375

beta.summary <- function(alpha, beta){
  
  mean <- alpha/(alpha+beta)
  var <- (alpha*beta)/( (alpha+beta)^2 * (alpha + beta + 1))
  sd <- sqrt(var)
  mode <- (alpha - 1)/(alpha + beta - 2)
  
  return(list(mean = mean,
              var = var,
              sd = sqrt(var),
              mode = mode)
  )
}

beta.hpd.interval <- function(alpha, beta){
  # This will break if either alpha < 1.0 or beta < 1.0
  # or alpha = beta = 1.0
  stopifnot(alpha >= 1.0, beta >= 1.0, !((alpha == 1) & (beta ==1)))
  
  interval.mass <- function(p.star){
    # Return the area under the curve for the 
    # set of points whose density >= p.star.
    
    f <- function(val){
      d <- dbeta(val, alpha, beta)
      if (d >= p.star){
        return(d)
      }
      else {return(0)}
    }
    
    return(integrate(Vectorize(f), 0.0, 1.0)$value)
    
  }
  
  err.fn <- function(p.star, hpd.mass=0.95){
    return((hpd.mass-interval.mass(p.star))^2)
  }
  
  max.f <- dbeta((alpha-1)/(alpha+beta-2), alpha, beta)
  
  Q <- optimize(err.fn, 
                interval = c(0, max.f)
  )
  
  precision <- 3
  p.star <- round(Q$minimum, precision)
  
  inside <- FALSE
  for (x in seq(0.0, 1.0, by=10^(-precision-1))) {
    if (round(dbeta(x, alpha, beta), precision) >= p.star) {
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
  
  return(list(alpha = alpha,
              beta = beta,
              p.star = p.star, 
              hpd.interval=interval))
}