# Observed data
x <- c(2.41, 5.37, 5.28, 4.89, 4.40, 4.63, 4.67, 4.52, 1.10, 3.86)

x
# Sufficient statistics
n <- length(x)
x.bar <- mean(x)
s.sq <- mean((x - x.bar)^2)