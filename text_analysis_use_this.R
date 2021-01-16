#http://www-stat.wharton.upenn.edu/~stine/mich/blalock/2_lsa.nb.html
library(tidyverse)
library(ggplot2)
library(data.table)
library(tm)
library(tidyverse)
require(tm)
require(wordcloud)
require(stringr)
require(tidyverse)
source("text_utils.R")

mediums_for_text_analysis <- fread('data/mediums_cleaned_for_text_analysis.csv', header = TRUE)
#View(mediums_for_text_analysis)
#number of rows used
numberOfDocsUse = 800

#min number of times the word has to occur in
requireNDocs=3

MediumsCorpus <- Corpus(VectorSource(mediums_for_text_analysis$Medium[1:numberOfDocsUse]))
#View(MediumsCorpus)
dtm <- DocumentTermMatrix(MediumsCorpus)
#dtm
#ni row
#mj column of marginal counts
ni <- rowSums(as.matrix(dtm))
mj <- colSums(as.matrix(dtm))
word.types <- names(mj)   # for convenience and clarity
#checking longest type for possible errors this is a word and is okay
word.types[j <- which.max(str_length(word.types))]


#extract the most frequent terms in the DTM
freqterms<-findFreqTerms(dtm,lowfreq=200)
#freqterms
#this returns:  "and","ink","paper","pencil","printed","with","from","one"    

#Handling Rare Words
#sort from most common to rare
# orders the terms, o continas the term ids.
o <- order(mj, decreasing=TRUE)   # biggest to smallest

#Out-of-vocabulary = OOV
#creating a list of words that appear less than # number of times
dtm.oov <- dtm[,requireNDocs <= mj]
#dtm.oov

#permanent OOV
#converting dtm into regular numerical matrix (later needed for SVD)
dtm.oov <- cbind(as.matrix(dtm.oov), rowSums(as.matrix(dtm[,mj < requireNDocs])))
dim(dtm.oov)
dim(dtm.oov)

names.oov  <- c(names(mj[requireNDocs<=mj]), 'OOV')
requireNDocs
mj.oov <- c(mj[requireNDocs<=mj],sum(mj[mj>requireNDocs]))
ni.oov <- ni                            # the same as it was
names.oov
dtm.oov
colnames(dtm.oov) <- names.oov
mj.oov
names(mj.oov) <- names.oov

#checking we didn't loose any terms
sum(dtm.oov)
sum(mj.oov)
sum(ni.oov)

#all good here


#doing normalization
#too large a matrix to compute inverse so instead approximating
dtm.oov
i.svd<-dtm.oov
dtm.svd<-dtm.oov
#
# number of words in a document, its length
ni.svd <- rowSums(dtm.svd)  
ni.svd
# frequency of word type in vocabulary (avoid 0 divisor)
mj.svd <- pmax(1,colSums(dtm.svd))

#min freq should be 10 or the n I set above
min(mj.oov)

#checking it is not a zero divisor
min(mj.svd)

#normalizing
dtm.svd <- dtm.svd/sqrt(ni.svd)    
dtm.svd <- t( t(dtm.svd)/sqrt(mj.svd) )

#compute SVD of scaled matrix of counts
udv <- svd(dtm.svd)        
dtm.svd

#looking at matrix u
plot(udv$u[1,],udv$u[2,])
plot(udv$u[2,],udv$u[3,])

#trying color
#udv needs to be in same order as df to color
plot(udv$u[1,],udv$u[2,], col = color)
plot(udv$u[2,],udv$u[3,], col = color)


#Doing it in GGPLOT
udv_df <- data.frame(udv$u)


View(mediums_for_text_analysis)

udv_df %>%
  select(X1:X10) %>% 
  add_column(class_color = mediums_for_text_analysis$Classification) %>%
  ggplot(aes(x=X2, y =X3, color=class_color)) + geom_point()




View(mediums_for_text_analysis)

pairs(udv$u[,2:5], #col=color,
      labels=c(expression("U"[2]), expression("U"[3]),  # subscripts in plot label
               expression("U"[4]), expression("U"[5])))

pairs(udv$u[,2:3], #col=color,
      labels=c(expression("U"[2]), expression("U"[3])))


#________________________________________________________________

library(uwot)

#umap dimensionality reduction
art_umap <- umap(dtm.oov)

art_umap %>% 
  as_tibble() %>% 
  add_column(class_color = mediums_for_text_analysis$Classification) %>%
  ggplot(aes(x=V1, y =V2, color=class_color)) + geom_point()

#_________________________________________________________________
ui <- fluidPage(
  #selectInput("var_y", "Y-Axis", choices = names(iris)),
  plotOutput("distPlot", hover = "plot_hover", hoverDelay = 0),
  uiOutput("dynamic")
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    art_umap %>% 
      as_tibble() %>% 
      add_column(class_color = mediums_for_text_analysis$Classification) %>%
      ggplot(aes(x=V1, y =V2, color=class_color)) + geom_point()
  })
  

  output$dynamic <- renderUI({
    req(input$plot_hover) 
    verbatimTextOutput("vals")
  })
  
  output$vals <- renderPrint({
    hover <- input$plot_hover 
    # print(str(hover)) # list
    y <- nearPoints(art_umap, input$plot_hover)
    req(nrow(y) != 0)
    y
  })
}
shinyApp(ui = ui, server = server)

