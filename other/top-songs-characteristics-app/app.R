# Purpose: Creates shiny app as a companion to the paper
# Author: Emily Su
# Date: 17 April 2024
# Contact: em.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have ran all scripts found in the scripts folder

# Referenced https://mastering-shiny.org/basic-ui.html for code
library(tidyverse)
library(shiny)
library(shinyWidgets)
library(ggplot2)

# Read in dataset
shiny_app_data <-
  read_csv("https://raw.githubusercontent.com/moonsdust/top-songs/ec993c0add1e9a2e2c1efa0fe2c3e68623209fed/other/top-songs-characteristics-app/shiny_app_data.csv",
    show_col_types = FALSE
  )

# Graph choice
graph_choice <- c("Track Duration", "Scale and Modality", "Loudness", "Tempo")

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel(h1("Song Characteristics of Top Songs from Billboard's
  Year-End Hot 100 singles list (2014 to 2023) before
             the pandemic and during and after the pandemic",
    align = "center"
  )),
  p('The following are the interactive version of visualizations from the
      dataset used by the paper "Characteristics of Top Songs Has Changed
        from Pandemic Brain"', align = "center", width = "50%"),

  # Sidebar with a slider input for number of bins and choose between graphs
  sidebarLayout(
    sidebarPanel(
      p("Created by Emily Su"),
      p("Last Updated: April 17, 2024"),
      p("GitHub repository: https://github.com/moonsdust/top-songs"),
      selectInput(
        "the_choice", "What song characteristic do you want to
                  view a graph for?",
        graph_choice
      ),
      sliderInput(
        inputId = "number_of_bins",
        label = "Number of bins:",
        min = 1,
        max = 50,
        value = 30
      ),
    ),

    # Show a plot based on user's choice
    mainPanel(plotOutput("curr_plot"))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Referenced https://stackoverflow.com/questions/38090443/how-to-get-choices
  # -values-of-selectinput-in-shiny
  output$curr_plot <- renderPlot({
    # Scale Plot
    if (input$the_choice == "Scale and Modality") {
      proportion_of_each_key_mode <-
        shiny_app_data |>
        # Group by if song was a hit before or during and after the pandemic
        group_by(period) |>
        # Count each scale
        count(key_mode) |>
        # rename count column to num_of_key_mode
        rename(
          "num_of_key_mode" = n
        ) |>
        mutate(
          proportion_key_mode = round(num_of_key_mode / sum(num_of_key_mode), 2)
        )

      proportion_of_each_key_mode |>
        ggplot(mapping = aes(x = key_mode, y = proportion_key_mode)) +
        facet_wrap(facets = vars(period), dir = "v") +
        geom_bar(stat = "identity", fill = "#3E509A") +
        theme_minimal() +
        labs(
          x = "Scale",
          y = "Proportion"
        ) +
        theme(axis.text.x = element_text(angle = 90))
    }
    # Track Duration Plot
    else if (input$the_choice == "Track Duration") {
      shiny_app_data |>
        ggplot(mapping = aes(x = track_duration_ms)) +
        facet_wrap(facets = vars(period), dir = "v") +
        geom_histogram(
          bins = input$number_of_bins,
          fill = "#e85569"
        ) +
        theme_minimal() +
        labs(
          x = "Duration of song (in ms)",
          y = "Count"
        )
    }
    # Loudness plot
    else if (input$the_choice == "Loudness") {
      shiny_app_data |>
        ggplot(mapping = aes(x = loudness)) +
        facet_wrap(facets = vars(period), dir = "v") +
        geom_histogram(bins = input$number_of_bins, fill = "#ECD078FF") +
        theme_minimal() +
        labs(
          x = "Loudness of song (in dB)",
          y = "Count"
        )
    }
    # Tempo plot
    else {
      shiny_app_data |>
        ggplot(mapping = aes(x = tempo)) +
        facet_wrap(facets = vars(period), dir = "v") +
        geom_histogram(bins = input$number_of_bins, fill = "#A7DBD8") +
        theme_minimal() +
        labs(
          x = "Tempo of song (BPM)",
          y = "Count"
        )
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
