library(shiny)
library(shinydashboard)

#source(file =  "ff.Rmd")

ui <- dashboardPage(
  
  title = "Analyse des rapatriements hebdomadaire",

  ################################################## entete  
  dashboardHeader( title = "Onet-Airport service ",
                   dropdownMenu(type = "messages",
                                    messageItem(
                                                  from = "Nouvel utilisateur",
                                                  message = "Comment s enregister ? ",
                                                  icon = icon("question"),
                                                  time = "13:45"
                                               )
                                
                                 ),
                   
                    dropdownMenu( type = "notification",
                                notificationItem(
                                                          text = "Attention",
                                                          icon = icon("warning"),
                                                          status = "success"
                                          
                                                )
                                ),
                   
                   dropdownMenu( type = "tasks",
                                taskItem(
                                  value = 80,
                                  color =  "aqua",
                                  "Calcul du nombre de missions"
                                )
      
                               
                               )
                                
                                
                              
                   
    
    
                   ),
  
  
  
  
################################################### Barre laterale  

  dashboardSidebar(



    sidebarMenu(
      
      menuItem("Tableau de bord", tabName = "tab", icon = icon("dashboard")),
      
      menuItem("Donnees",
               tabName = "donnees",
               icon = icon("users-cog"),
               # fileInput("file1", "choisisez votre fichier",
               #           multiple = FALSE,
               #           accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
               
               menuSubItem("Feuille d'analyse", tabName = "import" , icon = icon("file"))
                ),
      
      menuItem("Details par Agents", tabName = "agents", icon = icon("user-circle"),
               menuSubItem("Tout les agents", tabName = "totalagent",icon = icon("globe")),
               menuSubItem("Agents non Voltigeurs", tabName = "agent-n-volt"),
               menuSubItem("Agents Voltigeurs", tabName = "agent-volt")
               
               ),
      
      menuItem("Details par plages ",
               tabName = "plages",
               icon = icon("clock"),
               
               menuSubItem("Toutes les plages",
                           tabName = "totalplages",
                           icon = icon("globe")),
               
               menuSubItem("plage 1", tabName = "P1"),
               menuSubItem("Plage 2", tabName = "P2"),
               menuSubItem("Plage 3", tabName = "P3"),
               menuSubItem("Plage 4", tabName = "P4"),
               menuSubItem("Plage 5", tabName = "P5"),
               menuSubItem("Plage 6", tabName = "P6"),
               menuSubItem("Plage 7", tabName = "P7")
                ),
      
      menuItem("Details Typologies", tabName = "typo", icon = icon("typo3"),
               menuSubItem("Types de vols", tabName = "T-vols"),
               menuSubItem("Typologies bagages", tabName = "T-bagages")
               
              ),
      
      menuItem("Outils interactifs",tabName = "widgets" , icon =  icon("th"), badgeLabel = "Nouveau",badgeColor = "green"),
      menuItem("Detail de l'analyse", tabName = "Widgets" , icon =  icon("folder-open"))
        )
   
    
  ),





##################################################Corps du tableau


  dashboardBody(
    
    
    
    
    tabItems(
      
        tabItem( tabName = "tab",
                   
                 fluidRow(
                   
                   infoBox("Nombre de vols",          uiOutput("Nbvols"),   icon = icon("plane-arrival")),
                   infoBox("Nombre d'agents",         uiOutput("Nbagents"), icon = icon("male")),
                   infoBox("Nombre de voltigeurs",    uiOutput("Nbvolt"),   icon = icon("male")),
                   infoBox("Nombre de missions",      uiOutput("Nbmiss"),   icon = icon("people-carry")),
                   infoBox("Quantite de vrac",        uiOutput("Qtvrac"),   icon = icon("luggage-cart")),
                   infoBox("Quantite de conteneurs",  uiOutput("Qtctr"),    icon = icon("dolly-flatbed"))
                          
                          ),
 
                fluidPage(
                  
                  box( title = "histogramme",
                            status = "primary",
                            solidHeader = T,
                            plotOutput("histogram")),
                  
                  box( title = "Proportion de voltigeurs", status = "warning", solidHeader = T, plotOutput("propvolt")),
                  box( title = "Proportion de Missions",   status = "warning", solidHeader = T, plotOutput("propmissions"))
                  
                          )
      
              ),
      

      
       tabItem( tabName = "import",
                #shiny::fillPage(tabBox(tabPanel(dataTableOutput("contents")))), 
                
                fluidRow(
                  
                  box(dataTableOutput("Data voltigeurs"),
                      fileInput("file1", "choisisez votre fichier Voltigeurs", multiple = FALSE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                      
                      fileInput("file2", "Semaine analysable",multiple = FALSE,accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                      
                      actionButton("dem","Demarez le filtrage de donnees")
                      
                        ),
                  
                  
                fluidPage(
                  
                  box(
                    radioButtons("Analysisday","Jours a analyser" , choices = c("Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dimanche","Semaine"), selected = "Semaine"),
                    tags$hr(),
                      # radioButtons("tip_fich","Type de fichier" , choices = c("cc","stadard"), selected = "cc"),
                      # checkboxInput("header","Entete",TRUE),
                      # radioButtons("sep", " separation", choices = c( "Virgule" = ",", "Point-virgule" = ";", "Tabulation" = "\t"), selected = ";" ),
                      # radioButtons("disp", "Affichage", choices = c("Partiel" = "head","Total" = "all"),selected = "head"),
                      # tags$hr(),
                    actionButton("goAnalyse","Selection d'analyse")
                      #selectInput("jours","Analyse",c("All",unique(as.character(df$Date))),multiple = F)
                    ) 
                        )
                  
                      
                      )
                
                ),
  
              
        
      
      tabItem( tabName = "totalagent",
               h1("analyse total")
              ),
      
      tabItem( tabName = "agent-n-volt",
               h1("agents non voltigeurs")
              ),
      
      tabItem( tabName = "agent-volt",
               h1("agents voltigeurs")
              ),
 
      tabItem( tabName = "totalplages",
               h1("analyse total")
      ),
      tabItem( tabName = "P1",
               h1("P1")
      ),
      tabItem( tabName = "P2",
               h1("P2")
      ),
      tabItem( tabName = "P3",
               h1("P3")
      ),
      tabItem( tabName = "P4",
               h1("P4")
      ),
      tabItem( tabName = "P5",
               h1("P5")
      ),
      tabItem( tabName = "P6",
               h1("P6")
      ),
      tabItem( tabName = "P7",
               h1("P7")
      ),
      
      tabItem( tabName = "T-vols",h1("type de vols")),

      tabItem( tabName = "T-bagages", h1("typologie bagages") )
    
    )

  )






)
