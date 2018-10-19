---
title: Bayesian Multilevel Modelling
---

# About the lecturer:

Mark Andrews is a Senior Lecturer in the Psychology Department at Nottingham Trent University in Nottingham, England. Mark is a graduate of the National University of Ireland, and obtained an MA and PhD from Cornell University in New York. Mark’s research focuses on developing and testing Bayesian models of human cognition, with particular focus on human language processing and human memory. Mark’s research also focuses on general Bayesian data analysis, particularly as applied to data from the social and behavioural sciences. Since 2015, he and his colleague Professor Thom Baguley have been funded by the UK's ESRC funding body to provide intensive workshops on Bayesian data analysis for researchers in the social sciences. 

# Course description:

This course provides a general introduction to Bayesian multilevel modelling. Throughout, we will extensively use R and the Bayesian probabilistic programming language Stan and its R based brms interface. The course begins by providing a solid introduction to all the fundamental principles and concepts of Bayesian data analysis: the likelihood function, prior distributions, posterior distributions, high posterior density intervals, posterior predictive distributions, marginal likelihoods, Bayes factors, etc. We will do this using some simple models that are easy to understand and easy to work with. We then turn to providing a solid introduction to multilevel models, again beginning with conceptually and computationally simple multilevel models. We then proceed to more practically useful Bayesian multilevel models, and ones that necessarily require Monte Carlo methods, particularly multilevel general and generalized linear regression models. For these models and analyses, we will make extensive use of the R based brms interface to Stan, which allows general Bayesian multilevel regression to be done remarkably easily. As part of the introduction to multilevel regression, we will ensure that we first have a solid understanding of the (non-multilevel) general and generalized linear models. In final part of the course will cover multilevel models that are not regresison models per se. In particular, we will explore multilevel probabilistic mixture models, especially Latent Dirichlet Allocation and the Hierarchical Dirichlet Process model, which have been shown to be particularly valuable in the modelling of text data. Throughout the course, we will have interludes where we address some major general issues in Bayesian data analysis, particularly Markov Chain Monte Carlo methods and Bayesian model evaluation (e.g., using cross-validation, WAIC, and Bayes factors, etc).

# Keywords

Bayesian data analysis; multilevel models; general linear models; generalized linear models; probabilistic mixture models; Markov Chain Monte Carlo; R; Stan; brms; 

# Course prerequisites:

Participants need only have a experience in the usual range and repertoire of statistical methods as are typically taught in undergraduate social science courses. This would include familarity with classical (i.e. frequentist or sampling theory based) inference using hypothesis tests, p-values, and confidence intervals; familiarity with (multiple) linear regression, t-tests, analysis of variance models, etc. Expertise or extensive experience with R is not required, but a minimal familarity with R (as might be obtained from online video tutorials) would be helpful. No experience whatsoever with Bayesian analysis is required, nor is any experience with multilevel modelling.

# Target Group: 

Participants will find the course useful if they
 - Currently work with multilevel models such multilevel linear regression (also known as linear mixed effects models), and wish to learn more about Bayesian approaches to these models.
 - Currently work with, or wish to learn more about, extensions to the multilevel linear models, including multilevel logistic, Poisson, etc regression, and especially how to perform Bayesian analyses of these models.
 - Wish to learn more about the theoretical basis of multilevel modelling.
 - Wish to learn more about Bayesian data analysis generally.
 - Wish to learn how to use Bayesian probabilistic modelling languages such as Stan, and the R based brms interface to Stan.


# Course and Learning Objectives:
By the end of the course participants will
 - Understand the general principles of Bayesian data analysis.
 - Understand the theoretical basis of multilevel models.
 - Understand, and be able to perform, Bayesian analyses of multilevel general and generalized linear models.
 - Understand, and be able to perform, Bayesian model evaluation.
 - Be able to perform Bayesian data analysis using R, the probabilistic modelling language Stan, and the brms interface.

# Organisational Structure of the Course: 

The course will use a workshop, "hands-on", and interactive style approach from start to finish. There will front-lead teaching and instruction throughout, but even when dealing with the theoretical issues, we will use computational and graphical demonstrations to illustrate and elaborate the content, and participants will be able to simultaneously perform these demonstrations and visualizations on their own computers.
 
# Software and hardware requirements (please indicate here which software you intend to use):

Participants should bring their own laptop with the required software installed. All software is free and open-source, and may be installed and will perform identically on Windows, Macs, and Linux. The required software will be R, RStudio, Stan, brms, and a set of additional R packages. Further details and installation instructions are currently available at the website <http://www.priorexposure.org.uk/software>.

# Long Course Description: 

The aim of this course is to give a theoretical and practical introduction to
Bayesian approaches to multilevel modelling. Multilevel models are already
widely used throughout the social sciences, and their widespread use is likely
to continue to grow.  Statistical inference in multilevel models presents major
challenges for classical, i.e. sampling theory based, inference methods, while
inference using Bayesian methods is always possible in principle, and becomes
increasingly easy to perform in practice with ever more powerful Markov Chain
Monte Carlo (MCMC) techniques.

While the course will focus on multilevel models, we will also provide a solid
introduction to Bayesian data analysis and Bayesian theory generally. We will
also make extensive use of general purpose Bayesian data analysis software that
may be used for general data analysis, and not just multilevel models.

There will be five main sections, each occupying one day, as follows:

- Introducing Bayesian data analysis

  In this section, we aim to provide a solid and comprehensive coverage of
  all the fundamental principles of Bayesian data analysis. We will begin with
  the simple and uncontroversial application of Bayes' rule to calculations of
  conditional probability, and then examine how Bayes' rule can be used as the
  basis of general statistical inference. We will work through some conceptually
  simple but non-trivial statistical inference problems that are both easy to
  understand and computationally easy to caclulate yet nonetheless allow us to
  delve into all the key concepts of all Bayesian statistics such as the
  likelihood function, prior distributions, posterior distributions, maximum a
  posteriori estimation, high posterior density intervals, posterior predictive
  intervals, marginal likelihoods, Bayes factors, model evaluation of
  out-of-sample generalization.

- Introducing Bayesian multilevel models

  In this section, we begin by defining what multilevel models are, and why they arise in 
  so many practical or real-world data analysis problems. We will then explore some simple 
  Bayesian multilevel models including examples based on the beta-binomial model and the
  hierarchical normal model. In addition, in this section, we will introduce some general
  fundamental concepts in Bayesian multilevel modelling including hyperpriors, exchangeability,
  empirical Bayesian methods, pooling, shrinkage, etc.

- Multilevel linear regression models

  In this section, we will thoroughly explore the case of multilevel regression models, also 
  known as linear mixed effects models. These are extremely practically valueable and widely used
  models, and a solid understanding of them leads to a solid foundation for understanding many 
  but more complex multilevel models. As part of our coverage, we will consider the many 
  alternative, but ultimately equivalent, conceptualizations of multilevel linear regression models, 
  and how the relate to fixed versus random effects, and crossed versus nested effects. We will also 
  consider how these models effectively address many of the shortcomings of the repeated-measures 
  Anova models.

  In this section, given that we will be making extensive use of the Stan probabilistic modelling language, 
  primarily via the R based brms interface, we will devote sufficient time to explaining probabilistic 
  modelling languages, and why they are an, if not the, essential tool in any Bayesian modelling toolbox.
  We will also delve into the details of Markov Chain Monte Carlo methods, and explain their vital 
  role in Bayesian modelling generally.

- Multilevel generalized linear models

  Building upon the foundation laid down in the previous section, we now
  explore the plethora of multilevel generalized linear models and multilevel nonlinear regression models. These will
  include multilevel regression models for binary, categorical, ordinal and count
  models, including the well known cases such as logistic regression, Poisson
  regression, negative binomial regression.  We will also explore multilevel survival
  models, response time models, robust regression methods, and nonlinear regression 
  models including basis function regression models and Gaussian process regression 
  models.

- Multilevel mixture models

  In this final section, we will explore multilevel models that are not regression models per se. In particular, 
  we will explore multilevel probabilistic mixture models. Probabilistic mixture models 
  are examples of latent variable models, and in the social sciences, they sometimes go 
  by the name latent class models. We will provide a solid introduction to these models before 
  considering their multilevel counterparts. One of the most widely used and practically successful 
  multilevel mixture models is the Latent Dirichlet Allocation (LDA) model, which has been 
  widely employed in the modelling of text data. We will explore this model and some of its generalizations.
  As part of this coverage, we will also delve into the Bayesian nonparametric models, and 
  particularly hierarchical nonparametric models such as the Hierarchical Dirichlet Process mixture model.


# Day-to-day Schedule and Literature:

  - Day 1
    - Topic: Introducing Bayesian data analysis
    - Suggested reading: McElreath (2016) Statistical Rethinking. Chapters 1-3.
  - Day 2
    - Topic: Introducing Bayesian multilevel models
    - Suggested reading: Gelman et al (2014) Bayesian Data Analysis. Chapter 5. McElreath (2016) Statistical Rethinking. Chapter 12
  - Day 3
    - Topic: Multilevel linear regression models
    - Suggested reading: Gelman et al (2014) Bayesian Data Analysis. Chapter 15. Gelman & Hill (2007) Data Analysis using Regression and Multilevel/Hierarchical Models. Chapter 11-13.
  - Day 4
    - Topic: Multilevel generalized linear models
    - Suggested reading: Gelman et al (2014) Bayesian Data Analysis. Chapter 16. Gelman & Hill (2007).Data Analysis using Regression and Multilevel/Hierarchical Models.  Chapter 14-15.
  - Day 5
    - Topic: 
    - Suggested reading:

# Preparatory Reading: 

* Gelman et al (2014) Bayesian Data Analysis.
* McElreath (2016) Statistical Rethinking.
* Gelman & Hill (2007) Data Analysis using Regression and Multilevel/Hierarchical Models. 

# Recommended Literature to look at in advance:
* Carpenter et al (2017). Stan: A probabilistic programming language. Journal of statistical software, 76(1).
* Burkner (2017): brms: An R Package for Bayesian Multilevel Models Using Stan. Journal of statistical software, 80(1)
* Lambert (2018) A Student's Guide to Bayesian Statistics.
* Gill (2008) Bayesian Methods; A Social and Behavioural Sciences Approach.


