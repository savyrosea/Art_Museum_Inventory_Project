shinyServer(function(input, output, session) {
    
    
    #******** 0. ABOUT ***********
    # Make the word cloud drawing predictable during a session
    output$wordcloud_plot <- renderPlot({
        wordcloud_rep <- repeatable(wordcloud)

        
        d2 <- final_m[,input$decade_selection]
        
        #wordcloud(rownames(d1),final_m[,as.numeric(input$decade_selection)],c(8,.3),3,,TRUE,TRUE,.15,colors=brewer.pal(8, "Dark2"))
        wordcloud(rownames(d1),final_m[,as.numeric(input$decade_selection)],c(6,.2),input$freq,input$max,TRUE,TRUE,.15,colors=brewer.pal(8, "Dark2"))
    })
    
    # ********** 1. DISCREPANCIES IN THE DATA TAB **********
    
    
    
    # ********** 2. DIVERSITY OF ARTISTS AND ARTWORKS TAB **********
    #Gender Pie Chart
    output$Gender_Pie <-renderPlot({
        bp<- ggplot(pie_gender_data, aes(x="", y=value, fill=group))+
            geom_bar(width = 1, stat = "identity")
        
        pie <- bp + coord_polar("y", start=0)
        
        pie + blank_theme +
            labs(title = "Gender of Artists") +
            theme(axis.text.x=element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 24, face="bold"),
                  legend.title=element_blank(), 
                  legend.text=element_text(size=18)) +
            scale_fill_manual(values=c( "#FF5733", "#33B0FF", "#04263B"))
    })
    
    #Age Histogram
    Date_Made_Years <- filter(Moma_Artworks, Age_when_made<98)
    Date_Made_Years <- filter(Date_Made_Years, Age_when_made>10)
    
    output$Age_Hist <-renderPlot({
        ggplot(Date_Made_Years, aes(x=Age_when_made)) + 
            geom_histogram(color="black", fill="lightblue", binwidth=5) +
            ggtitle("Age of Artist when Art was Made") +
            xlab("Age") +
            ylab("Number of Artists")
    })
    
    
    #Sunburst Chart
    output$Nat_Sunburst <- renderPlotly(
        plot1 <- plot_ly(Moma_Artworks,
        #fig <- plot_ly(Moma_Artworks, x = ~Department, y = ~Artist_Born, type = 'bar', name = 'Trying Something') 
            labels = ~Nationality,
            parents = ~Region,
            values = ~Nat_Counts,
            type = 'sunburst'
        )
        
    )
    
    
    
    # ********** 3. TIME SERIES DATA TAB **********
    
    output$txt <- renderText({
        classes_text <- paste(input$Dep_Input, collapse = ", ")
        paste("You chose", classes_text)
    })
    
    
    d <- reactive({
        filtered <-
            Class_Counts %>%
                subset(Department %in% input$Dep_Input)
    }) 
    
    
    output$Dep_plot <- renderPlot({
        ggplot(d(), aes(x=year_acquired, y=counts, color=Department)) +
            geom_line(size = 1.15) + 
            theme_bw() +
            xlab("Year") +
            ylab("Number of Pieces Acquired") +
            ggtitle("Types of Artwork Acquired over time")
    })
    
    

    # ********** 4. IDENTIFYING SIMILAR ARTWORKS TAB **********
    

    
    
})
