
shinyUI(navbarPage(title = "MUSEUM OF MODERN ART INVENTORY ANALYSIS", inverse = TRUE,
                  
                   # ********** 1. ABOUT TAB **********
                   tabPanel("ABOUT", 
                        h1("About the App"),
                        tags$hr(style="border-bottom:12px; border-color: SteelBlue;"),
                        fluidRow(
                          column(width = 2,h5("")),
                          column(width = 4,img(src = "starry_night.PNG", height = 280, width = 390)),
                          column(width = 1,h5("")),
                          column(width = 3,h2("ARTISTS DASHBOARD"),
                                 h3("The ARTISTS DASHBOARD tab is designed to provide a snapshot 
                                 of the artists represented in MOMA. This dashboard provides 
                                 information on the the 
                                 artists' nationality, gender, and age when art was created as 
                                 well as displaying which artists 
                                 have the most pieces in MOMA's inventory.")),
                          column(width = 2,h5(""))
                        ),
                        tags$hr(style="border-color: SteelBlue;"),
                        fluidRow(
                          column(width = 2,h5("")),
                          column(width = 4,
                                 h2("ACQUISITION OVER TIME"),
                                 h3("The ACQUISITION OVER TIME tab allows user to view how the 
                                 quantity and mediums of the museum pieces acquired by year. 
                                 The line plot displays the number of pieces acquired 
                                 in each MOMA classification by year, and the wordcloud 
                                    displays the top mediums of the artworks aqcuired by decade.")),
                          column(width = 1,h5("")),
                          column(width = 4,img(src = "picasso.PNG", height = 400, width = 285)),
                          column(width = 1,h5(""))
                        ),
                        tags$hr(style="border-color: SteelBlue;"),
                        
                        fluidRow(
                          column(width = 2,h5("")),
                          column(width = 4,img(src = "boat.PNG", height = 300, width = 410)),
                          column(width = 1,h5("")),
                          column(width = 3,h2("ARTWORK MEDIUM TEXT ANALYSIS"),
                                 h3("The ARTWORK MEDIUM TEXT ANALYSIS tab is designed for the 
                                    user to explore similar pieces of art using text analysis 
                                    of the medium description MOMA provides for each piece of art.")),
                          column(width = 2,h5(""))
                        ),
                        tags$hr(style="border-color: SteelBlue;")
                        
                   ),
                   
                   # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
                   tabPanel("ARTISTS DASHBOARD",
                            #row with sunburst and lollipop
                            fluidRow(
                              column(width = 2,h2('')),
                              column(width = 3,h2('Nationality of Artist')),
                              column(width = 2,h2('')),
                              column(width = 5,h2('Artists with the Most Art in MOMA'))
                              #column(width = 1,h2(''))
                                     ),
                            fluidRow(
                              column(width = 6,plotlyOutput("Nat_Sunburst")),
                              column(width = 5,plotOutput("Artist_Lollipop")),
                              column(width = 1,h2(''))
                            ),
                            h3(""),
                            fluidRow(
                              column(width = 2,h2('')),
                              column(width = 4,h2('Artist Age When Art was Made')),
                              column(width = 1,h2('')),
                              column(width = 3,h2('Gender of Artists')),
                              column(width = 2,h2(''))
                            ),
                            #row with histogram and gender pie chart
                            fluidRow(
                              column(width = 1,h2('')),
                              column(width = 5,plotOutput("Age_Hist")),
                              column(width = 6,plotOutput("Gender_Pie"))
                              )
                            ),
                   
                   # ********** 3. TIME SERIES DATA TAB **********
                   tabPanel("ACQUISITION OVER TIME",
                            tabsetPanel(
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
                                         h2("  Top Mediums Acquired by Decade"),
                                         plotOutput("wordcloud_plot",width = "700px", height="400px")
                                       )),
                            tabPanel("Line Graph",
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
                                    plotOutput("Dep_plot", height = 480, width = 700)
                            ))
                            
                            
                                     
                   )),
                   
                  
                   # ********** 4. IDENTIFYING SIMILAR ARTWORKS TAB **********
                   tabPanel("ARTWORK MEDIUM TEXT ANALYSIS",
                            dashboardHeader(),
                            dashboardSidebar(),
                            dashboardBody(
                              fluidRow(
                                box(width = 1, h2('')),
                                box(width = 11, h2("Text Analysis of Artwork Mediums"))
                              ),
                              fluidRow(
                                box(width = 1, h2('')),
                                box(width = 7, plotlyOutput('plot')),
                                box(width = 4, htmlOutput('image'))
                              )
                            )
)))