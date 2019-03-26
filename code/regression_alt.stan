/*
*Normal regression example (alt)
*/

data {
  int<lower=0> N; // number of observations
  real y[N];    // outcome variables
  real x[N];    // predictor variables
}

parameters {
  real a; // the intercept
  real b; // the slope
  real<lower=0> sigma; //the standard deviation
}

model {  
  
  a ~ normal(0, 10);
  b ~ normal(0, 10);
  
  sigma ~ cauchy(0, 5);
  
  for (i in 1:N)
    y[i] ~ normal(a + b*x[i], sigma);
  
}
