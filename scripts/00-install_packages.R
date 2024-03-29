#### Preamble ####
# Purpose: Installs packages needed to run scripts and Quarto document
# Author: Emily Su
# Date: 2 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: -

#### Workspace setup ####
## Installing packages (only needs to be done once per computer)
install.packages("tidyverse") # Contains data-related packages
install.packages("knitr") # To make tables
install.packages("janitor") # To clean datasets
install.packages("dplyr")
install.packages("ggplot2") # To make graphs
install.packages("spotifyr") # Spotify API
install.packages("usethis") 
install.packages("arrow") # To allow Parquet files to be create
install.packages("ggcorrplot") # For correlation matrix
# For models
install.packages("rstanarm")
install.packages("modelsummary")