library(dplyr)
data<-read.csv("beer_data.csv")
getwd()
setwd("C:/Users/Pratik/Desktop/IMS Proschool/Advanced Machine Learning & Artificial Intelligence")
View(data)
summary(data)
sum(is.na(data))
#nrow(data[(is.na(data$review_profilename)| data$review_profilename==""),])
data<-data[!(data$review_profilename== ""),]
View(data) 

str(data)
summary(data)

#Choose only those beers that have at least N number of reviews, Find N using EDA.
beer_reviews_count <- data %>% group_by(beer_beerid) %>% summarise(totalbeerreviews=n())
beer_reviews_count
dim(beer_reviews_count)
summary(beer_reviews_count)
beer_reviews_count<-beer_reviews_count[order(beer_reviews_count$totalbeerreviews,decreasing = TRUE),]
View(beer_reviews_count)
head(beer_reviews_count,10) # top 10 users.
tail(beer_reviews_count,10) # least 10 users.
count_least_users<-beer_reviews_count %>% subset(totalbeerreviews==1)
dim(count_least_users) # there is 18056 users  review  is 1

#Clean data an find average beer & user ratings.
mean(data$beer_beerid)
mean(data$review_overall)

#Find similarity between the first 10 beers & first 10 users & plot this similarity matrix.
library(reshape2)
library(data.table)
beer_ratings = as.data.frame(acast(data, beer_beerid~review_overall , value.var="review_overall"))
View(beer_ratings)
bear_rating_cor = cor(beer_ratings[,1:10],use="complete.obs")
View(bear_rating_cor)



library(ggplot2)
g = ggplot(data, aes(data$review_overall)) +
  theme_classic()

g + geom_bar()


