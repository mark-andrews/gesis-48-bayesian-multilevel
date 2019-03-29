library(readr)
library(dplyr)
library(ggplot2)
library(brms)

# ===================================================
faithful <- read_csv('data/faithful.csv')
set.seed(101010)

mixreg_df <- tibble(
  x = rnorm(150),
  y = c(x[1:100], 5 + 2*x[101:150]) + rnorm(150)
)

# ===================================================

# Plot the histogram of eruptions of old faithful
ggplot(faithful,
       aes(x = eruptions)
) + geom_histogram(col='white', bins=30) + theme_classic()

# Plot the scatterplot of the mixture of linear regressions
ggplot(mixreg_df,
       aes(x = x, y = y)
) + geom_point()

# ========  mixture of normals ===============================
M <- brm(eruptions ~ 1,
         data = faithful,
         family = mixture(gaussian, gaussian),
         chains = 4,
         cores = 2)

# normal linear mixtures --------------------------------------------------

mixreg_prior <- c(
  prior(normal(0, 5), class=Intercept, dpar = mu1),
  prior(normal(0, 5), class=Intercept, dpar = mu2),
  prior(dirichlet(2, 2), class=theta)
)
M <- brm(y ~ x, 
         data=Df, 
         family = mixture(gaussian, nmix=2),
         prior = mixreg_prior, 
         chains = 2, 
         inits = 0)

summary(M)

# -------- zip -------------------------------------------
owls <- read_csv('data/owls.csv')

M <- brm(eruptions ~ 1,
         data = faithful,
         family = mixture(gaussian, gaussian),
         prior = the_prior,
         chains = 4,
         cores = 2)

# -------------------------------------------------------------
owls <- read_csv('data/owls.csv')

ggplot(owls,
       aes(x = SiblingNegotiation, fill = SexParent)
) + geom_histogram(position = 'dodge', binwidth = 1) + facet_wrap(~ FoodTreatment, nrow = 2)

Mzip <- brm(SiblingNegotiation ~ FoodTreatment + 
              SexParent + offset(log(BroodSize)) + (1|Nest),
            data = owls, 
            cores = 2, 
            prior = set_prior('normal(0, 100)'), 
            family = zero_inflated_poisson())

plot(Mzip, pars='^b_')

M_p <- brm(SiblingNegotiation ~ FoodTreatment + 
              SexParent + offset(log(BroodSize)) + (1|Nest),
            data = owls, 
            cores = 2, 
            prior = set_prior('normal(0, 100)'), 
            family = poisson())


Mzip2 <- brm(bf(SiblingNegotiation ~ FoodTreatment + 
                  SexParent + offset(log(BroodSize)) + (1|Nest),
                zi ~ FoodTreatment + SexParent),
             data = owls, 
             cores = 2, 
             prior = set_prior('normal(0, 100)'), 
             family = zero_inflated_poisson())

plot(Mzip2, pars='^b_')

Mzinb2 <- brm(bf(SiblingNegotiation ~ FoodTreatment + 
                  SexParent + offset(log(BroodSize)) + (1|Nest),
                zi ~ FoodTreatment + SexParent),
             data = owls, 
             cores = 2, 
             prior = set_prior('normal(0, 100)'), 
             family = zero_inflated_negbinomial())

plot(Mzinb2, pars='^b_')
