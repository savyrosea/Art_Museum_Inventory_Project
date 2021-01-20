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
library(scales)
library(treemap)
library(data.table)
require(stringr)
library(uwot)

#disabling scientific notation
options(scipen = 999)



# ***************** Loading in Data *****************
#Load in MOMA Data
Moma_Artworks <- read.csv(file = 'data/Moma_Artworks_Cleaned.csv')
Moma_Artists <- read.csv(file = 'data/Moma_Artists_Cleaned.csv')
#Reading in Mediums by decades df
Mediums_By_Decade <- fread("data/Mediums_By_Decade_temp.csv", header = TRUE)
#Reading in Mediums for text analysis
mediums_for_text_analysis <- fread('data/mediums_cleaned_for_text_analysis_classification.csv', header = TRUE)


# ***************** Pie Chart Prep *****************
#Getting Everything Prepped for the Gender Pie Chart
genders <- Moma_Artworks %>% count(Gender)

pie_gender_data <- data.frame(
  group=c('Male = 85.3%','Female = 14.7%','Non-Binary = 0.01%'),
  value=c(genders[2,2],genders[1,2],genders[3,2])
)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank()
  )


# ***************** Lolliop Graph Prep *****************
#Making Counts by Nationality and Region df
Artist_Counts <- Moma_Artists%>%
  select(Nationality, Region)%>%
  group_by(Region)

Artist_Counts$unis <- paste(Artist_Counts$Nationality,Artist_Counts$Region)
Artist_Counts$Number_Artists <- as.numeric(ave(Artist_Counts$unis, Artist_Counts$unis, FUN = length))
Artist_Counts <- Artist_Counts %>%
  drop_na()%>%
  distinct

Artist_Counts$Number_Artists
sum(Artist_Counts$Number_Artists)
Artist_Counts$percents <- (as.numeric(as.character(Artist_Counts$Number_Artists)) / 12590) * 100



# ***************** Sunburst Prep *****************
sun_df2 <- Moma_Artworks%>%
  select(Region, Nationality)%>%
  group_by(Region)%>%
  count(Region, Nationality, sort = TRUE)

index <- c('Asia','Africa','Middle East',
           'North and South America',
           'Europe', 'Australia and Pacific')
values <- c("#fef3d9","#add8e6",
            "#ffa07a","#ceead1",
            "#3ece1d4","#d0b3db")

sun_df2$col1 <- values[match(sun_df2$Region, index)]
Nationality <- c('Asia','Africa','Middle East',
                 'North and South America',
                 'Europe', 'Australia and Pacific')

Region <- c("","","",
            "","","")

n <- c(2834,1155,517,60784,53514,257)
col1 <- c("#fef3d9","#add8e6",
          "#ffa07a","#ceead1",
          "#ece1d4","#d0b3db")

data_to_combine <- data.frame(Nationality, Region, n, col1)
sun_df <- rbind(sun_df2,data_to_combine)



# ***************** Line Plot Prep *****************
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



# ***************** Wordcloud Prep *****************
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




# ***************** Text Analysis Prep ****************
#adding classification to text analysis
# mediums_for_text_analysis <- mediums_for_text_analysis %>%
#   add_column(Medium2 = paste(mediums_for_text_analysis$Classification,
#                              mediums_for_text_analysis$Medium))

#number of rows used
numberOfDocsUse = 1200

#min number of times the word has to occur in
requireNDocs=3

MediumsCorpus <- Corpus(VectorSource(mediums_for_text_analysis$Medium[1:numberOfDocsUse]))
MediumsCorpus <- tm_map(MediumsCorpus, removePunctuation)
MediumsCorpus <- tm_map(MediumsCorpus, removeWords, c("a", "an", "the", "from", "with", "and"))

dtm <- DocumentTermMatrix(MediumsCorpus)
ni <- rowSums(as.matrix(dtm))
mj <- colSums(as.matrix(dtm))
word.types <- names(mj) 


#extract the most frequent terms in the DTM
freqterms<-findFreqTerms(dtm,lowfreq=200)

#Handling Rare Words
#sort from most common to rare
# orders the terms, o continas the term ids.
o <- order(mj, decreasing=TRUE)   # biggest to smallest

#Out-of-vocabulary = OOV
#creating a list of words that appear less than # number of times
dtm.oov <- dtm[,requireNDocs <= mj]

#permanent OOV
#converting dtm into regular numerical matrix (later needed for SVD)
dtm.oov <- cbind(as.matrix(dtm.oov), rowSums(as.matrix(dtm[,mj < requireNDocs])))
#View(dtm.oov)

#________________________________________________________________
#View(mediums_for_text_analysis)
#umap dimensionality reduction
art_umap <- umap(dtm.oov, n_sgd_threads = 'auto') %>%
  as_tibble() %>% 
  add_column(classification = mediums_for_text_analysis$Classification) %>%
  add_column(title = mediums_for_text_analysis$Title) %>%
  add_column(artist = mediums_for_text_analysis$Artist) %>%
  add_column(id = mediums_for_text_analysis$ConstituentID) %>% 
  add_column(medium = mediums_for_text_analysis$Medium) %>% 
  add_column(thumbnail = mediums_for_text_analysis$ThumbnailURL)


