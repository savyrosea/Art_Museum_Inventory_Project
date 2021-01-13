# **Art_Museum_Midcourse_Project**
## Midcourse Project - Savannah Sew-Hee

## **Executive Summary**

###### For this project I am completing an inventory analysis on the art collection at the Museum of Modern Art (MOMA). The purpose of this R-Shiny app is to allow the museum or an art dealer to look at an inventory of artworks and be able to determine the following things.

###### 1)	Look at discrepancies in their dataset so they can go back and fix it. For example, for a few artworks in the dataset the date the piece was made is before the date the artist is born. The museum could then go back and investigate entries like these.

###### 2)	Look at the diversity of Artists (Nationality and Gender) and Artworks (Category and Medium). This will be useful if the museum wants to put together similar pieces for a display (such as a display of Australian Art or a display of Paintings from the 1940's). This will also be useful so that the museum can decide which types of art to acquire so that they have a more diverse inventory.

###### 3)	Look at time series data. This could show what type or how much art was acquired by decade or year.

###### 4)	Look at identifying similar art pieces. Using K-nearest neighbors I could demonstrate how unique a piece of art is based on how far away from its neighbors it is. I could also use k-nearest neighbors to show similar art pieces given an art piece. The data set has a link to a thumbnail for each piece of art so I hope to display some of the art predictions within the R-Shiny app.

###### 5)	Provide accurate summary information for museum visitors and donors. This will enable them to effectively recruit new donors.

###### I hope to make a separate page on the website for each of these things, but I realize I probably will not get to all of them due to time restraints.

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
