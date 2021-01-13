
shinyUI(navbarPage(title = "Art Museum Project", inverse = TRUE,
                  
                   # ********** 1. ABOUT TAB **********
                   tabPanel("ABOUT", 
                        h2("About the App...")
                   ),
                   
                   # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
                   tabPanel("DIVERSITY OF ARTISTS",
                            #row with sunburst and lollipop
                            fluidRow(
                              column(width = 6,plotlyOutput("Nat_Sunburst")),
                              column(width = 6,plotOutput("Artist_Lollipop"))
                            ),
                            fluidRow(h1(" ")),
                            fluidRow(h1(" ")),
                            #row with histogram and gender pie chart
                            fluidRow(
                              column(width = 6,plotOutput("Age_Hist")),
                              column(width = 6,plotOutput("Gender_Pie"))
                              )),
                   
                   # ********** 3. TIME SERIES DATA TAB **********
                   tabPanel("DATA OVER TIME",
                            tabsetPanel(
                            tabPanel("Line Graph",
                              sidebarLayout(
                                  sidebarPanel(
                                    checkboxGroupInput("Dep_Input", "Classification",
                                                       choices = c("Drawings & Prints",
                                                                   "Photography",
                                                                   "Architecture & Design",
                                                                   "Painting & Sculpture",
                                                                   "Media and Performance",
                                                                   "Film"),
                                                       selected = c("Drawings & Prints",
                                                                  "Photography"))
                                  ),
                                mainPanel(
                                  plotOutput("Dep_plot")
                                )
                            )),
                            
                            tabPanel("Word Cloud",
                                     sidebarPanel(
                                       selectInput("decade_selection",
                                                   "Choose a decade:",
                                                   choices = c("1930s" = "1",
                                                               "1940s" = "2",
                                                               "1950s" = "3",
                                                               "1960s" = "4",
                                                               "1970s" = "5",
                                                               "1980s" = "6",
                                                               "1990s" = "7",
                                                               "2000s" = "8",
                                                               "2010s" = "9")),
                                       hr(),
                                       sliderInput("freq",
                                                   "Minimum Frequency:",
                                                   min = 1,  max = 50, value = 20),
                                       sliderInput("max",
                                                   "Maximum Number of Words:",
                                                   min = 1,  max = 300,  value = 200)
                                     ),
                                     
                                     # Show Word Cloud
                                     mainPanel(
                                       h2("  Top Mediums Used by Decade"),
                                       plotOutput("wordcloud_plot",width = "500px", height="400px")
                                     ))
                                     
                   )),
                   
                  
                  
                   # ********** 4. IDENTIFYING SIMILAR ARTWORKS TAB **********
                   tabPanel("IDENTIFYING SIMILAR ARTWORK MEDIUMS",
                            sidebarLayout(
                                sidebarPanel(
                                    h2('Hi... text here')
                                ),
                                mainPanel(
                                    h2('Hi... text here')
                                )
                            )    
                   )
))