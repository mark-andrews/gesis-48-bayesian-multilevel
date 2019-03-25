# Scaled inverse chi sq
curve(dinvchisq(x, 5, 2), 
      from=0.0, to=10.0, 
      col='chocolate', 
      n=1001, xlab='x', ylab='P(x)')