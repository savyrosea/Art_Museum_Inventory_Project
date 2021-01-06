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
        pie_race_data <- data.frame(
            group=c('Male','Female','Non-Binary'),
            value=c(genders[2,2],genders[1,2],genders[3,2])
        )
        pie_race_data <- pie_race_data %>% 
            arrange(desc(group)) %>%
            mutate(prop = value / sum(pie_race_data$value) *100) %>%
            mutate(ypos = cumsum(prop)- 0.5*prop)
        
        ggplot(pie_race_data, aes(x="", y=value, fill=group)) +
            geom_bar(stat="identity", width=1) +
            coord_polar("y", start=0) +
            theme_void() +
            labs(title = 'Gender') +
            theme(plot.title = element_text(hjust = 0.5, size = 14,face="bold")) +
            scale_fill_manual(values=c( "#FF5733", "#33B0FF", "#04263B"))
    })
    
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
