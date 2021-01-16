shinyServer(function(input, output, session) {
    
    #******** 1. ABOUT ***********
    # Make the word cloud drawing predictable during a session
    
    
    # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
    
    # 2.1 Gender Pie Chart
    output$Gender_Pie <-renderPlot({
        bp<- ggplot(pie_gender_data, aes(x="", y=value, fill=group))+
            geom_bar(width = 1, stat = "identity", color = 'black')
        
        pie <- bp + coord_polar("y", start=0)
        
        pie + blank_theme +
            #labs(title = "  Gender of Artists") +
            theme(axis.text.x=element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 24, face="bold"),
                  legend.title=element_blank(), 
                  legend.text=element_text(size=16)) +
            scale_fill_manual(values=c( "#ffa07a", "#add8e6", "#04263B"))
    })
    
    # 2.2 Age Histogram
    Date_Made_Years <- filter(Moma_Artworks, Age_when_made<98)
    Date_Made_Years <- filter(Date_Made_Years, Age_when_made>10)
    output$Age_Hist <-renderPlot({
        ggplot(Date_Made_Years, aes(x=Age_when_made)) + 
            geom_histogram(color="black", fill="lightblue", binwidth=5) +
            #ggtitle("Age of Artist when Art was Made") +
            xlab("Age") +
            ylab("Number of Artists") +
            theme(plot.title = element_text(hjust = 0.5, size = 24, face="bold"),
                  axis.title.x = element_text(size = 16, face="bold"),
                  axis.title.y = element_text(size = 16, face="bold"),
                  axis.text.x = element_text(size = 16),
                  axis.text.y = element_text(size = 16))
    })
    
    # 2.3 Lollipop Graph
    output$Artist_Lollipop <-renderPlot({
        Artist_Counts <- Moma_Artworks%>%
            select(Artist)%>%
            group_by(Artist)%>%
            summarize(n=n())
        Artist_Counts <- filter(Artist_Counts, n>850)
        Artist_Counts[1,1] <- "Eugene Atget"
        Artist_Counts$Artist <- factor(Artist_Counts$Artist,levels = c("Eugene Atget",
                                                                       "Louise Bourgeois",
                                                                       "Ludwig Mies van der Rohe",
                                                                       "Jean Dubuffet",
                                                                       "Lee Friedlander",
                                                                       "Pablo Picasso",
                                                                       "Marc Chagall",
                                                                       "Henri Matisse",
                                                                       "Pierre Bonnard",
                                                                       "Frank Lloyd Wright"))
        artist_x <- Artist_Counts$Artist
        artist_y <- Artist_Counts$n
        # Plot
        ggplot(Artist_Counts, aes(x=artist_x, y=artist_y)) +
            geom_point(stat = "identity") + 
            geom_segment( aes(x=artist_x, xend=artist_x, y=0, yend=artist_y), size = 1) +
            geom_point( size=5, color="red",
                        fill=alpha("orange", 0.3),
                        alpha=0.7, shape=21, stroke=2) +
            #theme_bw() +
            coord_flip() +
            #ggtitle("Artists with the Most Artwork in MOMA") +
            xlab("                 Number of Art Pieces") +
            ylab("Artist Name") +
            theme(
                panel.grid.major.y = element_blank(),
                panel.border = element_blank(),
                axis.ticks.y = element_blank(),
                plot.title = element_text(hjust = 0.5, size = 24, face="bold"),
                axis.title.x = element_text(size = 16, face="bold"),
                axis.title.y = element_text(size = 16, face="bold"),
                axis.text.x = element_text(size = 16),
                axis.text.y = element_text(size = 16)
            )
    })
    
    # 2.4 Sunburst Chart
    output$Nat_Sunburst <- renderPlotly(
        plot_ly(sun_df,
                #ids = sun_df$Nationality,
                labels = sun_df$Nationality,
                parents = sun_df$Region,
                values = sun_df$n,
                type = 'sunburst',
                branchvalues = 'total')
            #layout(list(title = "Nationality of Artists", size = 5))
    )
    
    
    
    # ********** 3. TIME SERIES DATA TAB **********
    #reactive to subset df for department
    d <- reactive({
        filtered <-
            Class_Counts %>%
                subset(Department %in% input$Dep_Input)
    }) 
    
    #Line Plot Acquisition Over Time
    output$Dep_plot <- renderPlot({
        ggplot(d(), aes(x=year_acquired, y=counts, color=Department)) +
            geom_line(size = 1.02) + 
            theme_bw() +
            xlab("Year") +
            ylab("Number of Pieces Acquired") +
            ggtitle("Types of Artwork Acquired Over Time \n") +
            theme(plot.title = element_text(hjust = 0.5, size = 24, face="bold"),
            legend.title=element_blank(), 
            legend.text=element_text(size=14),
            axis.title.x = element_text(size = 16, face="bold"),
            axis.title.y = element_text(size = 16, face="bold"),
            axis.text.x = element_text(size = 16),
            axis.text.y = element_text(size = 16))
    })
    
    # Wordcloud by decade plot
    output$wordcloud_plot <- renderPlot({
        wordcloud_rep <- repeatable(wordcloud)
        d2 <- final_m[,input$decade_selection]
        wordcloud(rownames(d1),
                  final_m[,as.numeric(input$decade_selection)],
                  c(5,.5),input$freq,
                  input$max,TRUE,TRUE,.15,
                  colors=brewer.pal(8, "Dark2"))
    })
    

    # ********** 4. IDENTIFYING SIMILAR MEDIUMS TAB **********


})
