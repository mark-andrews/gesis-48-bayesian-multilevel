/*
*Normal regression example
*/

data {
  int<lower=0> N; // number of observations
  vector[N] y;    // outcome variables
  vector[N] x;    // predictor variables
}

parameters {
  real a; // the intercept
  real b; // the slope
  real<lower=0> sigma; //the standard deviation
}

transformed parameters {
  vector[N] mu;
  mu = a + b * x;
}

model {  
  a ~ normal(0, 10);
  b ~ normal(0, 10);
  sigma ~ cauchy(0, 5);
  y ~ normal(mu, sigma);
}
