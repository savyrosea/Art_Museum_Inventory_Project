
shinyUI(navbarPage(title = "Art Museum Project", inverse = TRUE,
                   
                   
                   # ********** 0. ABOUT TAB **********
                   tabPanel("ABOUT", 
                            sidebarPanel(
                              selectInput("decade_selection", "Choose a decade:",
                                          choices = c("1930s" = "1",
                                                      "1940s" = "2",
                                                      "1950s" = "3",
                                                      "1960s" = "4",
                                                      "1970s" = "5",
                                                      "1980s" = "6",
                                                      "1990s" = "7",
                                                      "2000s" = "8",
                                                      "2010s" = "9")),
                              
                              #actionButton("update", "Change"),
                              hr(),
                              sliderInput("freq",
                                          "Minimum Frequency:",
                                          min = 1,  max = 50, value = 15),
                              sliderInput("max",
                                          "Maximum Number of Words:",
                                          min = 1,  max = 300,  value = 100)
                            ),
                            
                            # Show Word Cloud
                            mainPanel(
                              plotOutput("wordcloud_plot",width = "500px", height="500px")
                            )
                   ),
                   
                   
                   
                   # ********** 1. DISCREPANCIES IN THE DATA TAB **********
                   tabPanel("DISCREPANCIES IN DATA",
                            sidebarLayout(
                                sidebarPanel(
                                    h2('Hi... text here')
                                ),
                                mainPanel(
                                    h2('Hi... text here')
                                )
                            )    
                   ),
                   
                   
                   
              
                   # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
                   tabPanel("DIVERSITY OF ARTISTS AND ARTWORKS",
                            sidebarLayout(
                                sidebarPanel(
                                    h2('Hi... text here')
                                ),
                                mainPanel(
                                  tabsetPanel(type = "tabs",
                                              tabPanel("Artists", 
                                                       plotOutput("Gender_Pie"),
                                                       plotlyOutput("Nat_Sunburst")),
                                              tabPanel("Artworks", 
                                                       h2('categories'))
                                  )
                                )
                            )    
                   ),
                   
                   
                   
                   # ********** 3. TIME SERIES DATA TAB **********
                   tabPanel("TIME SERIES",
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
                                                                  "Photography")),
                                  
            
                                ),
                                mainPanel(
                                  textOutput("txt"),
                                  plotOutput("Dep_plot")
                                )
                            )    
                   ),
                   
                   # ********** 4. IDENTIFYING SIMILAR ARTWORKS TAB **********
                   tabPanel("IDENTIFYING SIMILAR ARTWORK",
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