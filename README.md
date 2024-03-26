# Analysis of top songs before, during, and after 2020 and their popularity as determined by Spotify

## Overview

## Important Notes
- `raw_playlists_data.csv` was last updated **Friday Mar 22 2:19am EDT**
- `popularity` column is updated frequently by Spotify and there is a chance that the results 
when replicated might be slightly off from what is described in the paper if `01-download_data.R` is 
ran to replace the current `raw_playlists_data.csv` file.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

No LLMs were used for any aspect of this work.