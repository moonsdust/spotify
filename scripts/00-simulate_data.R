#### Preamble ####
# Purpose: Simulates data of songs from different playlists on Spotify.
# Author: Emily Su
# Date: 2 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-install_packages.R has been ran to install necessary packages.


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
simulated_data <- 
  tibble(
    year = sample(x=c("2018", "2019", "2020", "2021", "2022", "2023"), size = 1000, replace = TRUE),
    loudness = rnorm(n = 1000, mean = 100, sd = 10),
    mode_name = sample(x=c("minor", "major"), size = 1000, replace = TRUE),
  )



