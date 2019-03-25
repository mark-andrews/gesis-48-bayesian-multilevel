library(brms)
library(ggplot2)

ggplot(faithful,
       aes(x = eruptions)
) + geom_density()

ggplot(faithful,
       aes(x = eruptions)
) + geom_histogram(col='white', bins=30) + theme_classic()

M <- brm(eruptions ~ 1,
         data = faithful,
         family = mixture(gaussian, gaussian),
         chains = 4,
         cores = 2)

