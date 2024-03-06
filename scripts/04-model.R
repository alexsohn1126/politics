#### Preamble ####
# Purpose: Creates the model from the downloaded data
# Author: Moohaeng Sohn
# Date: March 5th, 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Prereq: Install previous scripts
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

set.seed(853)

analysis_data <- 
  analysis_data |> 
  slice_sample(n = 1000)

### Model data ####
first_model <-
  stan_glm(
    formula = voted_for ~ gender + education,
    data = analysis_data,
    family = binomial(link="logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

prior_summary(first_model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


