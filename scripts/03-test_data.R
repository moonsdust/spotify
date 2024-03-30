#### Preamble ####
# Purpose: Tests the clean dataset of top songs. 
# Author: Emily Su
# Date: 2 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-install_packages.R, 01-download_data.R, and 02-data_cleaning.R 
# has been ran to install necessary packages, download raw data, and 
# clean the data, respectively.

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

#### Test data ####
analysis_data <- read_parquet("data/analysis_data/playlists_analysis_data.parquet")

stopifnot(
  # If all the conditions in here are True, then it will return NULL
  # 1. hit_year is numeric 
  class(analysis_data$hit_year) == "numeric",
  # 2. hit_year contains 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023
  analysis_data$hit_year |> sort() |> unique() == c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023),
  
  # 3. Check that track_popularity is numeric 
  class(analysis_data$track_popularity) == "numeric",
  # 4. track_popularity has a min number that is equal or greater than 0
  analysis_data$track_popularity |> min() >= 0,
  # 5. track_popularity has a max number that is less than or equal to 100
  analysis_data$track_popularity |> max() <= 100,
  
  # 6. Check energy is numeric 
  class(analysis_data$energy) == "numeric",
  # 7. energy has a min number that is equal or greater than 0.0
  analysis_data$energy |> min() >= 0.0,
  # 8. energy has a max number that is less than or equal to 1.0
  analysis_data$energy |> max() <= 1.0,
  
  # 9. Check loudness is numeric 
  class(analysis_data$loudness) == "numeric",
  # 10. loudness has a min number that is equal or greater than -60
  analysis_data$loudness |> min() >= -60,
  # 11. loudness has a max number that is less than or equal to 0
  analysis_data$loudness |> max() <= 0,
  
  # 12. Check valence is numeric 
  class(analysis_data$valence) == "numeric",
  # 13. valence has a min number that is equal or greater than 0.0
  analysis_data$valence |> min() >= 0.0,
  # 14. valence has a max number that is less than or equal to 1.0
  analysis_data$valence |> max() <= 1.0
)

# 15. mode_name's class is character
expect_equal(class(analysis_data$mode_name), "character") 
# 16. mode_name's unique observations are: "major", "minor"
expect_equal(sort(unique(analysis_data$mode_name)), sort(c("major", "minor")))
# 17. key_mode's class is character 
expect_equal(class(analysis_data$key_mode), "character") 
# 18. key_mode's unique observations are "F minor", "F# major", "G# major", "A# minor", "C# minor", "C# major", 
# "A major", "C major", "B major", "G major", "D major", "D# major", 
# "C minor", "F major", "E minor", "E major", "G minor", "A minor", 
# "B minor", "F# minor", "G# minor", "A# major", "D minor", "D# minor"
expect_equal(sort(unique(analysis_data$key_mode)), sort(c("F minor", "F# major", "G# major", "A# minor", "C# minor", "C# major", 
                                                           "A major", "C major", "B major", "G major", "D major", "D# major", 
                                                           "C minor", "F major", "E minor", "E major", "G minor", "A minor", 
                                                           "B minor", "F# minor", "G# minor", "A# major", "D minor", "D# minor")))


# 19. Check that there are 1000 observations in the dataset total
expect_length(analysis_data$hit_year, 1000)
