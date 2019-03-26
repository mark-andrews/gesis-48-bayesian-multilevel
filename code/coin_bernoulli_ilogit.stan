data {
  int<lower=0> n;
  int<lower=0, upper=1> y[n];
}

parameters {
  real alpha;
}

transformed parameters {
  real<lower=0, upper=1> theta;
  theta = inv_logit(alpha);
}

model {
  alpha ~ normal(0, 10);
  
  for (i in 1:n)
    y[i] ~ bernoulli(theta);

}
