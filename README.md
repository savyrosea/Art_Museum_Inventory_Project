# **Art_Museum_Midcourse_Project**
##  Savannah Sew-Hee




## **Executive Summary**

#### R Shiny App for This Project: https://savyrosea.shinyapps.io/art_museum_midcourse_project/

##### For this project I am completing an inventory analysis on the art collection at the Museum of Modern Art (MOMA). This R shiny app is split into the following three categories:

##### 1) A dashboard demonstrating the diversity of the artists represented in MOMA.	This dashboard will display the artists nationality, gender, and age at time artwork was created. This dashboard will also provide a snapshot of which artists has the most pieces in MOMA's collection.


<p float="left">
  <img src="https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/sunburst.PNG" width="370" />
  <img src="https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/lollipop.PNG" width="520" />
</p>

##### 2)	Look at time series data. This could show what type or how much art was acquired by decade or year. This can be viewed as a word cloud which focuses on a more aesthetically pleasing view of which artwork mediums were most acquired by decade.

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/line.PNG)

##### The user can also look at dataa over time using a line graph. This Line graph displays categories of art acquired by year. The line graph view of this data allows the user to views spikes in art collection, and well as which categories of art have been growing over time.

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/wordcloud1.PNG)

##### 3)	Look at identifying similar art pieces using text mining on the artwork's medium description. Using the description of mediums of each piece of artwork, I created a document term matrix (DTM) containing a count of words occurred in each medium description. I then mapped the DTM into two dimension using UMAP dimensionality reduction, and used the two numbers to plot each point as a scatter plot. This plot is intereactive and visually shows artworks with similar mediums based on their proximity.

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/scatter4.PNG)

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/scatter2.PNG)

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/scatter3.PNG)




## **Why is this App Useful?**
##### This app can be used by many people associated with the art museum world (beyond your everyday art enthusist like myself). 
##### Archivists - Catalog art pieces by medium and record artwork as it has been acquired over time
##### Curators - Identify similar art pieces based on medium to create a exhibition
##### Donors - View a summary of the art collection before making a donation



## **Data Sources**
##### https://github.com/MuseumofModernArt/collection
 
##### This is the official Museum of Modern Art's GitHub and has two csv's (one on artworks and one on artists) that are taken directly from the Museum of Modern Art's API and are updated monthly.



## **Data Questions**

##### What does the population of artists represented at MOMA look like?
##### How has MOMA's artwork acquisition changed over time?
##### Can we use text mining to find similar artworks based on the description of the art medium used?



## **Data Cleaning Challenges**

##### Cleaning the data took some time. For example,
##### .	Artist Column has some entries with more than one artist (up to 48 artists) which also means Artist Birth column has more than one year in it
##### .	Year Made column is entered differently each time. For example: Dec. 2nd, 1955 or 1960-1962 or c. 1884
##### .	Some Artists are listed as being born after their artwork was created, after looking into this, I discovered that these cases are objects that an artist owned that where created before the artist was born.

## **Process for Creating Scatter Plot and Plotting Artwork Mediums using Text Mining**
##### 1) Took a sample size of 1200 unique mediums from my data set
##### 2) Created a document term matrix (DTM) with the counts of each word used in each medium. At this step I also removed a list of stopword such as "from", "the", and "as". I used this article to help me create my DTM 
##### https://cran.r-project.org/web/packages/text2vec/vignettes/text-vectorization.html
##### http://www-stat.wharton.upenn.edu/~stine/mich/blalock/2_lsa.nb.html
##### 3) I used the uwot package in R to preform, UMAP dimensionality reduction to map my DTM down to two dimesions. I uses the two numbers as x and y coordinates and plotting as a scatter plot to view similair artworks by medium description.
##### https://cran.r-project.org/web/packages/uwot/uwot.pdf
##### (The code for this is found in Second_Round_Cleaning_in_R.R)
