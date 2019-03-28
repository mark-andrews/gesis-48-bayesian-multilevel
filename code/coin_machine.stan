data {
  int<lower=0> J;
  int<lower=0> n;
  int<lower=0> m[J];
}

parameters {
  real mu;
  real<lower=0> tau;
  real alpha[J];
}

transformed parameters {
  
  real<lower=0, upper=1> theta[J];
  
  for (j in 1:J)
    theta[j] = inv_logit(alpha[j]);
    
}

model {
  
  // hyper-priors 
  mu ~ normal(0, 10);
  tau ~ cauchy(0, 5);
  
  for (j in 1:J){
    alpha[j] ~ normal(mu, tau);      //
    m[j] ~ binomial(n, theta[j]); //
  }

}
