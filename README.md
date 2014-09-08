PSA Velocity - Shiny App
=============

Please find the source code for the tool presented in:
"Prostate-Specific Antigen Velocity is an important Prostate Cancer predictive marker in a prospective PSA based screening study".(Christos Mikropoulos et al. 2014).

installation
------------

Before running the app you will need to have R and RStudio installed (tested with R 3.0.2 and RStudio 0.97.449).

- Please run those lines in R:
  - install.packages("shiny")
  - install.packages("devtools")
  - devtools::install_github("shiny-incubator","rstudio")
  - install.packages("ggplot2")
  - install.packages("shinyAce")

- Run the tool:
  - shiny::runGitHub("PSA_Velocity", "zx8754")

Your web browser will open the web app.
