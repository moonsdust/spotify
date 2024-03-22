#### Preamble ####
# Purpose: Downloads and saves the data from Spotify.
# Author: Emily Su
# Date: 2 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-install_packages.R has been ran to install the necessary packages.

# IMPORTANT NOTE ABOUT THIS SCRIPT:
# 1. popularity column is updated frequently by Spotify and there is a chance that 
# the results when replicated might be slightly off from what is described in the paper if 
# this script is ran. 

# 2. If this script does not run it is likely because you need to create a 
# Spotify Developer Account and a new app for spotifyr. After doing this,
# call library("usethis") in your console in your RStudio environment, 
# call edit_r_environ() to open the .Renviron file and add in the following 
# with the values changed to your new app's Client ID and Client Secret, which can 
# be found in your new app's settings:

# SPOTIFY_CLIENT_ID = 'PUT_YOUR_CLIENT_ID_HERE'
# SPOTIFY_CLIENT_SECRET = 'PUT_YOUR_SECRET_HERE'

# For more detail, please see https://www.rcharlie.com/spotifyr/

#### Workspace setup ####
library(tidyverse)
library(spotifyr)

#### Download data ####
spotify_username <- 'spotify'
# 2018 Playlist: Top Hits of 2018
playlist_2018_path <- "37i9dQZF1DXe2bobNYDtW8"
# 2019 Playlist: Top Hits of 2019 
playlist_2019_path <- "37i9dQZF1DWVRSukIED0e9"
# 2020 Playlist: Top Tracks of 2020 
playlist_2020_path <- "37i9dQZF1DX7Jl5KP2eZaS"
# 2023 Playlist: Top Tracks of 2023
playlist_2023_path <- "37i9dQZF1DX18jTM2l2fJY"

# Vector containing all the playlist paths
playlist_paths <- c(playlist_2018_path, playlist_2019_path, playlist_2020_path, playlist_2023_path)

# Get data on playlists' audio features 
raw_playlists_data <- get_playlist_audio_features(playlist_username, playlist_paths)

#### Save data ####
write_csv(raw_playlists_data, "data/raw_data/raw_playlists_data.csv") 