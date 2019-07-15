
library(shiny)
library(shinydashboard)
library(DT)
#source(file = "ff.Rmd")

server <- function(input, output)
{
  
  
  
  output$histogram <- renderPlot({hist(rnorm(100))})
  
  output$uni <- renderPlot({ hist(rnorm(100))})
  
  output$userpanel1 <- renderUI({ 
    if( !is.null(sessionInfo())){
                                  sidebarUserPanel(
                                  span("Logged in as",sessionInfo()),
                                  subtitle = a(icon("sign-out"), "logout", href = "__logout__"))
                                }
                                })
  
  output$voltigeurs <- renderDataTable({
                              req(input$file1)
                              tryCatch({df <- data.frame(read.csv2(input$file1$datapath, header = input$header, sep = input$sep ,quote ='"', dec = ",",na.strings = ""))

                                        #if(input$jours != "All"){df <- df[df$Date == input$jours, ]}

                                        },
                                            error = function(e) { stop(safeError(e))}

                                      )
                                            width = "0"                  
                              if(input$disp == "head"){ return(head(df))}else{return(df)}
                                            
                                    })
  
  output$Nbvols    <- renderInfoBox({  })
  output$Nbagents  <- renderInfoBox({})
  output$Nbvolt    <- renderInfoBox({})
  output$Nbmiss    <- renderInfoBox({})
  output$Qtvrac    <- renderInfoBox({})
  output$Qtctr     <- renderInfoBox({})
  
  
  
  
  

  
}