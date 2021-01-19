# **Art_Museum_Midcourse_Project**
## Midcourse Project - Savannah Sew-Hee

## **Executive Summary**

###### For this project I am completing an inventory analysis on the art collection at the Museum of Modern Art (MOMA). The purpose of this R-Shiny app is to allow the museum or an art dealer to look at an inventory of artworks and be able to determine the following things.


###### 1) Create a dashboard demonstrating the diversity of the artists represented in MOMA.	Look at the diversity of Artists (Nationality and Gender) . This will be useful if the museum wants to put together similar pieces for a display (such as a display of Australian Art or a display of Paintings from the 1940's). This will also be useful so that the museum can decide which types of art to acquire so that they have a more diverse inventory.

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/sunburst.PNG)

###### 2)	Look at time series data. This could show what type or how much art was acquired by decade or year.

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/line.PNG)

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/wordcloud1.PNG)

###### 3)	Look at identifying similar art pieces using text mining on the artwork's medium description

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/scatter1.PNG)

![](https://github.com/savyrosea/Art_Museum_Midcourse_Project/blob/main/images/scatter2.PNG)

## **Motivation**

###### I like making and observing art, so I personally found this dataset interesting. I wanted to find a dataset that interested me, and then do analysis that another company might find useful for their dataset as well. By doing this inventory analysis, I can take what I have learned and made for this R shiny app and apply it to a company's data set of their products in order to help a company visualized the products they have, discrepancies in their dataset, and suggest new unique products to add to their collection.

## **Data Question**

###### Are their contradictions in their dataset they should go back and update?
###### How diverse is MOMA's collection of artwork?
###### How does the artwork MOMA has acquired change from decade to decade?
###### What pieces of art are the most similar to other and which are the most unique?


## **Data Sources**
###### https://github.com/MuseumofModernArt/collection
 
###### This is the official Museum of Modern Art's GitHub and has two csv's (one on artworks and one on artists) that are taken directly from the Museum of Modern Art's API and are updated monthly.

## **Known Issues and Challenges**

###### 1)	It will be difficult to clean some of the text columns. For example,
###### .	Artist Column has some entries with more than one artist (up to 48 artists) which also means Artist Birth column has more than one year in it
###### .	Year Made column is entered differently each time. For example: Dec. 2nd, 1955 or 1960-1962 or c. 1884
###### .	Medium Column is a list describing each piece and each entry is very unique, I may need to do text analysis to do anything with it

###### 2)	If I want to try to predict artwork using K-nearest neighbors, there is not a lot of numerical data to do this with (only dimension and year columns). I may need to find a way to predict using categorically using the region of the world or the classification of the artwork. If this takes too much time to learn I might not be able to pull this off, but I think there is still plenty of project here without it.
###### 3)	I'm not sure if I can display the artwork thumbnails within my app or if this breaks some copyright rule.
