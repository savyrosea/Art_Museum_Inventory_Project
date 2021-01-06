library(shiny)
library(tidyverse)
library(ggplot2)
library(shinydashboard)
library(RColorBrewer)
library(plotly)
library(tm)
library(wordcloud)
library(memoise)
library(data.table)
options(scipen = 999)


#Load in MOMA Data
Moma_Artworks <- read.csv(file = 'data/Moma_Artworks_Cleaned.csv')
#View(Moma_Artworks)

Moma_Artists <- read.csv(file = 'data/Moma_Artists_Cleaned.csv')
#View(Moma_Artists)

genders <- Moma_Artworks %>% count(Gender)





#Making Counts by Class and year df
Class_Counts <- Moma_Artworks%>%
  select(Department, year_acquired)%>%
  group_by(year_acquired)

Class_Counts$unis <- paste(Class_Counts$Department,Class_Counts$year_acquired)
Class_Counts$counts <- as.numeric(ave(Class_Counts$unis, Class_Counts$unis, FUN = length)) 

Class_Counts%>%
  distinct

Class_Counts <- Class_Counts %>% drop_na()
Class_Counts%>%
  subset(Department %in% c("Film","Photography"))





#Making Counts by Nationality and Region df
Artist_Counts <- Moma_Artists%>%
  select(Nationality, Region)%>%
  group_by(Region)

Artist_Counts$unis <- paste(Artist_Counts$Nationality,Artist_Counts$Region)
Artist_Counts$Number_Artists <- as.numeric(ave(Artist_Counts$unis, Artist_Counts$unis, FUN = length)) 


Artist_Counts <- Artist_Counts %>%
  drop_na()%>%
  distinct

#View(Artist_Counts)
Artist_Counts$Number_Artists

sum(Artist_Counts$Number_Artists)

Artist_Counts$percents <- (as.numeric(as.character(Artist_Counts$Number_Artists)) / 12590) * 100




#Reading in Mediums by decades df
#Mediums_By_Decade <- read.csv(file = 'data/Mediums_By_Decade_temp.csv')
Mediums_By_Decade <- fread("data/Mediums_By_Decade_temp.csv", header = TRUE)
#View(Mediums_By_Decade)






# taken from server wordcloud
temp_mat <- Mediums_By_Decade$mediums
temp_mat <- list(Mediums_By_Decade$mediums[1],
                 Mediums_By_Decade$mediums[2],
                 Mediums_By_Decade$mediums[3],
                 Mediums_By_Decade$mediums[4],
                 Mediums_By_Decade$mediums[5],
                 Mediums_By_Decade$mediums[6],
                 Mediums_By_Decade$mediums[7],
                 Mediums_By_Decade$mediums[8],
                 Mediums_By_Decade$mediums[9])

myCorpus1 = Corpus(VectorSource(temp_mat))
myCorpus1 = tm_map(myCorpus1, content_transformer(tolower))
myCorpus1 = tm_map(myCorpus1, removePunctuation)
myCorpus1 = tm_map(myCorpus1, removeNumbers)
myCorpus1 = tm_map(myCorpus1, removeWords, c(stopwords("SMART"), "it", "is", "gelatin", "silver"))

myDTM1 = TermDocumentMatrix(myCorpus1, control = list(minWordLength = 1))

final_m = as.matrix(myDTM1)
sort(rowSums(final_m), decreasing = TRUE)

d1 <- data.frame(final_m)


















#Romeo WOrd Cloud Example
text<-list("This is my first book.
       And it is short movie movie.", "And this is my second book. 
           It is a little bit longer, finally. 9 ", "Finally the third. 
           It is a movie not a book.")
myCorpus = Corpus(VectorSource(text))
myCorpus = tm_map(myCorpus, content_transformer(tolower))
myCorpus = tm_map(myCorpus, removePunctuation)
myCorpus = tm_map(myCorpus, removeNumbers)
myCorpus = tm_map(myCorpus, removeWords,
                  c(stopwords("SMART"), "it", "is"))
#myCorpus
myDTM = TermDocumentMatrix(myCorpus,
                           control = list(minWordLength = 1))
myDTM
m = as.matrix(myDTM)
#View(m)
sort(rowSums(m), decreasing = TRUE)
d <- data.frame(m)
wordcloud(rownames(d),m[,1],c(8,.3),0,,TRUE,TRUE,.15,colors=brewer.pal(8, "Dark2"))

