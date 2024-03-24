#### Preamble ####
# Purpose: Cleans the dataset on Spotify playlists and outputs a parquet file. 
# Author: Emily Su
# Date: 2 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-install_packages.R and 01-download_data.R has been ran to install necessary packages
# and download raw data. 

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)

#### Clean data ####
# Read in raw data 
raw_data <- read_csv("data/raw_data/raw_playlists_data.csv", show_col_types = FALSE)

# Clean column names 
cleaned_data <- 
  raw_data |>
  clean_names()

# Select columns: playlist_name, track_name, track_album_name, 
# track_duration_ms, track_popularity, danceability, energy, loudness, valence, 
# tempo, mode_name, key_mode
cleaned_data <- 
  cleaned_data |>
  select(playlist_name, track_name, track_album_name, 
         track_duration_ms, track_popularity, danceability, energy, loudness, valence, 
         tempo, mode_name, key_mode)

# Create hit_year column and remove playlist_name column
cleaned_data <- 
  cleaned_data |>
  mutate(
    hit_year = case_when(
      (playlist_name == "Top Hits of 2018") ~ 2018,
      (playlist_name == "Top Hits of 2019") ~ 2019,
      (playlist_name == "Top Tracks of 2020") ~ 2020,
      (playlist_name == "Top Tracks of 2023") ~ 2023,
      TRUE ~ 0
    )
  ) |>
  select(
    hit_year, track_name, track_album_name, 
    track_duration_ms, track_popularity, danceability, energy, loudness, valence, 
    tempo, mode_name, key_mode
  )
  
#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/playlists_analysis_data.parquet")