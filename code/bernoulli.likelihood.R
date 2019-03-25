# R plot of Bernoulli likelihood function.

n <- 250 # Number of trials. E.g coin tosses.
m <- 139 # Number of successes. E.g Heads.

par(cex.lab=1.2,
    cex.axis=1.0,
    mar = c(4,5,0,0) )

y.label = "$\\theta^m  (1-\\theta)^{n-m}$"
x.label = "$\\theta$"

curve(x^m*(1-x)^(n-m), 
      from = 0, 
      to = 1, 
      n=1001,
      xlab=expression(theta),
      ylab=expression(theta^m * (1-theta)^(n-m)),
      yaxt='n',
      axes=F)

x.ticks <- seq(0, 1, 0.1)
axis(1, at=x.ticks, labels=x.ticks, col.axis="black", las=1)

max.limit <- 1.0 * ((m/n)^m*(1-(m/n))^(n-m))
y.ticks <- seq(0, max.limit, length.out = 5)
axis(2, at=y.ticks, labels=rep('',5), col.axis="black", las=1)