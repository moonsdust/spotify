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
data <- 
  tibble(
    level = rnorm(n = 1000, mean = 100, sd = 10) |> floor(),
    weakness = sample(x=c("fire", "not first"), size = 1000, replace = TRUE)
  )



