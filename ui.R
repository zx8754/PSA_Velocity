# Load shiny library
library(shiny)
library(shinyAce)

# All UI elements must be inside shinyUI()
shinyUI(
  
  pageWithSidebar(
    headerPanel(h3("PSA Velocity"),windowTitle="PSA Velocity"),
    
    sidebarPanel(
      h5("Paste data below:"),
      tags$textarea(id="PasteData", rows=10, cols=50, placeholder="SampleID,PSA_Date,PSA","Sample_1,19/09/2008,0.77
Sample_1,15/01/2010,0.48
Sample_1,11/03/2011,0.7
Sample_1,23/03/2012,0.53
Sample_2,19/09/2008,0.77
Sample_2,15/01/2010,0.48
Sample_3,11/03/2011,0.7"),
      p(),
      actionButton('clearText_button','Clear data'),
      radioButtons("fileSepP", "Field Separator:", list("Comma"=1,"Tab"=2,"Semicolon"=3))
      ),#pageWithSidebar
    
    mainPanel(
      
      tabsetPanel(type = "pills",
        # Welcome tab
        tabPanel("Input Data",tableOutput("PSAV")),
        tabPanel("Result",
                 tableOutput("PSAV_result"),
                 downloadButton("downloadResult", "Download")),
        tabPanel("Plot",
                 uiOutput("SampleID"),
                 plotOutput("SamplePlot"),
                 tableOutput("PSAV_result_selected")),
        tabPanel("Help",
                 #withMathJax(),
                 #helpText('An irrational number \\(\\sqrt{2}\\) and a fraction $$1-\\frac{1}{2}$$'),
                 HTML('<p>This application was developed with XYZ journal Methods as described in this <a href="http://www.ncbi.nlm.nih.gov/pubmed">editorial</a>. <p> The application allows users to calculate PSA velocity using <a href="http://www.ncbi.nlm.nih.gov/pubmed/17197071">three methods</a> from Connolly D paper:<p>'),
                 helpText("1. Arithmetic equation of change in PSA over time (AE)"),
                 helpText("2. Linear regression (LR)"),
                 helpText("3. Rate of PSA change using first and last values only (FL)"),
                 HTML('<p>A data matrix can be pasted into the application.
                      <p>PSA Velocity code can be run locally via <a href="https://github.com/zx8754/PSA_Velocity">GitHub</a>.'),
				h5("Software references"),
				HTML('<p>R Development Core Team. <i><a href="http://www.r-project.org/">R</a>:  A Language and Environment for Statistical Computing.</i> R Foundation for Statistical Computing, Vienna (2013) <br>
				     RStudio and Inc. <i><a href="http://www.rstudio.com/shiny/">shiny</a>: Web Application Framework for R.</i> R package version 0.5.0 (2013) <br>'),
				h5("Further references"),
				HTML('<p> Connolly D1, Black A, Murray LJ, Napolitano G, Gavin A, Keane PF: <a href="http://www.ncbi.nlm.nih.gov/pubmed/17197071"> Methods of calculating prostate-specific antigen velocity. </a></p>'),
				h6("This application was created by the ",
           a("T.Dadaev", href="https://twitter.com/zx8754"), " and ",
           a("Prof. R. Eeles", href="http://www.icr.ac.uk/our-research/researchers-and-teams/professor-rosalind-eeles"),
           " labs."))
        )#tabsetPanel
    )#mainPanel
      )#sidebarPanel
      )
