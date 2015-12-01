
#setwd("./Documents/STATS133")

#Necessary libraries
#Found @:https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment
library(base64enc)
library(httpuv)
library(httr)
library(rjson)
library(bit64)
library(sentiment)
library(dplyr)
library(devtools)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)
library(twitteR)

#Since sentiment package is not supported anymore, we need to download the source code
#Found @: http://colinpriest.com/2015/07/04/tutorial-using-r-and-twitter-to-analyse-consumer-sentiment/
install_url("http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")
#Only need to do this once

#Need to introduce how to create an developer account on Twitter than an app
#Next how to access the key, secret, token and acess secret. 
#Need to tell users that this information is sensitive and should be kept private. 
#This block essentially allows R to search for Tweets
setup_twitter_oauth(consumer_key = "*****", 
                    consumer_secret = "*****",
                    access_token = "*****",
                    access_secret = "*****")

#Select 1 when asked to use a local file to cache OAuth 

#Get tweets with a certain pattern in it, set the number of tweets and language.

McDsample <- searchTwitter(searchString = "McDonalds", n = 200, lang = "en")

#Get tweets and abstract away unnecessary text
McDtext <- sapply(McDsample, function(x) x$getText())

#Getting rid of Twitter usernames
McDtext <-  gsub("@\\w+", "", McDtext)
#Getting rid of Retweet (aka RT) pattern
McDtext <- gsub("RT", "", McDtext)
#Getting rid of punctuation characters
McDtext <- gsub("[[:punct:]]", "", McDtext)
#Getting rid of annoying http links 
McDtext <- gsub("http\\w+", "", McDtext)
#Getting rid of emojis 
McDtext <- sapply(McDtext, function(row) iconv(row, "latin1", "ASCII", sub=""))
names(McDtext) <- NULL
McDtext <- unique(McDtext)

McDdf <- data.frame(Tweet = substr(McDtext, 1, 40),
                    Polarity = sentiment(McDtext))
McDdf$Polarity.text <- NULL


#THINGS TO KEEP IN MIND:
#calculate some key word frequencies about some foods
#how frequent are about some events/topic in relation to McDonalds
###########Example: hepatitis outbreak


#how often is a restaurant mentioned across time and geography




