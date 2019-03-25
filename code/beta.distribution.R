# Two alternative plotting functions of the beta distribution.

# Standard parameterization
beta.plot <- function(alpha, beta){
  curve(dbeta(x, alpha, beta), 
        ylab=expression("P" * (theta)),
        xlab=expression(theta),
        from=0, 
        to=1, 
        n=1001)
}

# Parameterization in terms of location and concentration.
beta.plot.2 <- function(a, m){
  curve(dbeta(x, a*m, a*(1-m)), 
        ylab=expression("P" * (theta)),
        xlab=expression(theta),       
        from=0, 
        to=1, 
        n=1001)
}

# Also shows the hpd interval.
beta.plot.hpd <- function(alpha, beta){
  
  HPD <- beta.hpd.interval(alpha, beta)
  
  hpd.interval <- HPD$hpd.interval
  p.star <- HPD$p.star
  
  curve(dbeta(x, alpha, beta), 
        ylab=expression("P" * (theta)),
        xlab=expression(theta),
        from=0, 
        to=1, 
        n=1001)
  
  segments(hpd.interval[1], p.star, hpd.interval[2], p.star, lwd=1)
  
}

# Also shows the hpd interval.
beta.plot.hpd.2 <- function(alpha, beta){
  
  HPD <- beta.hpd.interval(alpha, beta)
  
  hpd.interval <- HPD$hpd.interval
  p.star <- HPD$p.star
  
  x <- seq(hpd.interval[1],
           hpd.interval[2],
           length.out = 1001)
  
  y <- dbeta(x, alpha, beta)
  x <- c(hpd.interval[1], x, hpd.interval[2])
  y <- c(0, y, 0)
  
  plot.new()
  plot(NULL, NULL,
       ylab=expression("P" * (theta)),
       xlab=expression(theta),
       xlim=c(0,1),
       ylim=c(0, 1.1 * dbeta((alpha-1)/(alpha+beta-2), alpha, beta))
  )
  
  polygon(x, y, col="lavender", lty=2)
  
  curve(dbeta(x, alpha, beta), 
        ylab='',
        xlab='',
        from=0, 
        to=1, 
        n=1001,
        add=T)
  
  #segments(hpd.interval[1], p.star, hpd.interval[2], p.star, lwd=1)
 
}






