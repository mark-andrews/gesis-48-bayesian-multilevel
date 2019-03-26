library(dplyr)
library(ggplot2)

# I don't like the default theme in ggplot.
theme_set(theme_classic())


# Assume we have N (by default 100) marbles in an urn.
# Some are red, the remainder are black.
# We sample n marbles *with* replacement.
# We find m are red, so n-m are black.
# Return the likelihood function for 
# each of the (N+1) possible numbers of 
# red marbles in the urn.
binomial_likelihood <- function(m, n, N){
  
  x <- seq(0, N)
  p <- x/N
  
  tibble(x = x,
         y = p^m * (1-p)^(n-m)
  )
}

plot_binomial_likelihood <- function(m, n, N){
  title <- sprintf('Likelihood. %d red having sampled %d with replacement from urn with %d', m, n, N)
  binomial_likelihood(m, n, N) %>% fplot('likelihood', title)
}

# Assume we have N (by default 100) marbles in an urn.
# Some are red, the remainder are black.
# We sample n marbles *without* replacement.
# We find m are red, so n-m are black.
# Return the likelihood function for 
# each of the (N+1) possible numbers of 
# red marbles in the urn.
hypergeometric_likelihood <- function(m, n, N){
  
  tibble(x = seq(0, N),
         y = dhyper(m, x, N-x, n)
  )
}

plot_hypergeometric_likelihood <- function(m, n, N){
  title <- sprintf('Likelihood. %d red having sampled %d without replacement from urn with %d', m, n, N)
  hypergeometric_likelihood(m, n, N) %>% fplot('likelihood', title)
}


fplot <- function(Df, ylabel=NULL, title=NULL){
  ggplot(Df,
         aes(x = x, y = y)) + 
    ylab(ylabel) +
    geom_bar(stat='identity', width = 0.5) +
    ggtitle(title)
}


uniform_prior <- function(N){
  tibble(
    x = seq(0, N),
    y = 1/(N+1)
  )
}

pseudo_normal_prior <- function(N, mean, sd){
  x <- seq(0, N)
  y <- dnorm(x, mean=mean, sd=sd)
  tibble(
    x = x,
    y = y/sum(y)
  )
}

crazy_prior <- function(N, K=5){
  y <- sample(seq(K), size = N+1, replace = T)
  tibble(x = seq(0, N),
         y = y/sum(y)
  )
}

make_posterior <- function(likelihood, prior){
  
  # Do some checking
  stopifnot(all_equal(likelihood$x, prior$x))
  
  posterior <- likelihood$y * prior$y
  prior %>% 
    mutate(y = posterior/sum(posterior))
}

