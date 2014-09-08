library(ggplot2)
library(shiny)
library(shinyAce)
source("udf_PSA_velocity.R")
       
shinyServer(
  function(input, output, session) {
    
    #if Clear pressed then clear the text box
    observe({
      if (input$clearText_button == 0) return()
      isolate({ updateTextInput(session, "PasteData", label = ",", value = "") })
    })
    
    #Input Data Tab --------------------------------------------------------------
    #Convert pasted text into a dataframe
    datPSA <- reactive({
      if(is.null(input$PasteData)) {return(NULL)}
      mySep<-switch(input$fileSepP, '1'=",",'2'="\t",'3'=";")
      x <- matrix(strsplit(input$PasteData, "\n")[[1]])
      x <- do.call(rbind,lapply(x,function(i){strsplit(i,mySep)[[1]]}))
      x <- data.frame(SampleID=x[,1],
                      PSA_Date=x[,2],
                      PSA=as.numeric(x[,3]),stringsAsFactors = FALSE)
    })
    
    #Get results using udf_PSA_velocity function
    datPSAResult <- reactive({udf_PSA_velocity(datPSA())})

    #Show input data as table on "Input Data" tab
    output$PSAV <- renderTable({
      datPSA()
      })
    
    #Result Tab --------------------------------------------------------------
    #Output for "Result" tab
    output$PSAV_result <- renderTable({
      datPSAResult()
    }, digits=4)
    
    #Option to download Results
    output$downloadResult <- downloadHandler(
      filename = function() { 
        "PSAV_results.csv" 
      },
      content = function(file) {
        write.csv(datPSAResult(), file,row.names=FALSE)})
    
    #Plot Tab --------------------------------------------------------------
    #Dynamic input - Select Sample for plot
    output$SampleID <- renderUI({
      selectInput("SampleID", strong("Sample ID:"),
                  choices = sort(unique(datPSA()$SampleID)))
    })
    
    ##plot for selected sample
    output$SamplePlot <- renderPlot({
      d <- datPSA()[ datPSA()$SampleID == input$SampleID,]
      d$PSA_Date <- as.Date(d$PSA_Date,"%d/%m/%Y")
      d$FirstLast <- ifelse(d$PSA_Date %in% c(min(d$PSA_Date,na.rm=TRUE),
                                              max(d$PSA_Date,na.rm=TRUE)),1,0)
      ggplot(d,
             aes(x=PSA_Date,y=PSA)) +
        geom_point() +
        geom_line(colour="green") +
        geom_smooth(method=lm,se=FALSE) +
        geom_line(data=d[ d$FirstLast==1 & !(is.na(d$PSA)),],
                  aes(x=PSA_Date,y=PSA),col="red") +
        theme_classic()
      
    })
    output$PSAV_result_selected <- renderTable({
      datPSAResult()[datPSAResult()$SampleID==input$SampleID,]
    }, digits=4)
    
    
  }
)#shinyServer
