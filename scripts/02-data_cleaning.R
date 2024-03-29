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
library(dplyr)

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
      (playlist_name == "2014 Billboard Year End Hot 100") ~ 2014,
      (playlist_name == "2015 Billboard Year End Hot 100") ~ 2015,
      (playlist_name == "2016 Billboard Year End Hot 100") ~ 2016,
      (playlist_name == "2017 Billboard Year End Hot 100") ~ 2017,
      (playlist_name == "Billboard Year-End Hot 100: 2018") ~ 2018,
      (playlist_name == "Billboard Year-End Hot 100: 2019") ~ 2019,
      (playlist_name == "Billboard Year-End Hot 100: 2020") ~ 2020,
      (playlist_name == "Billboard Year-End Hot 100: 2021") ~ 2021,
      (playlist_name == "Billboard Year-End Hot 100: 2022") ~ 2022,
      (playlist_name == "Billboard Year-End Hot 100: 2023") ~ 2023,
      TRUE ~ 0
    )
  ) |>
  select(
    hit_year, track_name, track_album_name, 
    track_duration_ms, track_popularity, danceability, energy, loudness, valence, 
    tempo, mode_name, key_mode
  ) 

# Remove duplicate rows
cleaned_data <- distinct(cleaned_data)

#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/playlists_analysis_data.parquet")