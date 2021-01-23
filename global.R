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

#**** Reading in saved workspace from "Second_Round_Cleaning_in_R" to speed up run time *******
load(file = "mywordspace.rda")

