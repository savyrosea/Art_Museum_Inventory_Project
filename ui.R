
shinyUI(navbarPage(title = "Art Museum Project", inverse = TRUE,
                  
                   # ********** 1. ABOUT TAB **********
                   tabPanel("ABOUT", 
                        h1("About the App"),
                        h6("_____________________________________"),
                        h2("ARTISTS DASHBOARD"),
                        h4("Some words about the dashboard"),
                        h2("ACQUISITION OVER TIME"),
                        h4("Some words about the Plots over time"),
                        h2("ARTWORK MEDIUMS TEXT ANALYSIS"),
                        h4("Some words about the text Analysis")
                   ),
                   
                   # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
                   tabPanel("ARTISTS DASHBOARD",
                            #row with sunburst and lollipop
                            fluidRow(
                              column(width = 1,h2('')),
                              column(width = 4,h2('Nationality of Artist')),
                              column(width = 3,h2('')),
                              column(width = 4,h2('Artists with the Most Artwork in MOMA'))
                                     ),
                            fluidRow(
                              column(width = 6,plotlyOutput("Nat_Sunburst")),
                              column(width = 6,plotOutput("Artist_Lollipop"))
                            ),
                            fluidRow(
                              column(width = 1,h2('')),
                              column(width = 4,h2('Age of Artist When Art was Made')),
                              column(width = 3,h2('')),
                              column(width = 4,h2('Gender of Artists'))
                            ),
                            #row with histogram and gender pie chart
                            fluidRow(
                              column(width = 6,plotOutput("Age_Hist")),
                              column(width = 6,plotOutput("Gender_Pie"))
                              )),
                   
                   # ********** 3. TIME SERIES DATA TAB **********
                   tabPanel("ACQUISITION OVER TIME",
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
                                       plotOutput("wordcloud_plot",width = "500px", height="500px")
                                     ))
                                     
                   )),
                   
                  
                   # ********** 4. IDENTIFYING SIMILAR ARTWORKS TAB **********
                   tabPanel("ARTWORK MEDIUMS TEXT ANALYSIS",
                            dashboardHeader(title = "Popups"),
                            dashboardSidebar(),
                            dashboardBody(tags$head(tags$style(
                              HTML("img.small-img {
                              max-width: 75px;
                                   }")
                            )),
                            plotlyOutput("hoverplot", height = "600px"),
                            uiOutput(outputId = "image"))
)))