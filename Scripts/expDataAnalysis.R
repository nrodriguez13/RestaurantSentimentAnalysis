####::::::::::::::::::::::Exploratory Data Analysis::::::::::::::::::::::::::####
#This scripts attempts to gain a glimpse of the data's behavior. We will perform
#sentiment analysis, take at look at word frequencies and some other summary
#statistics.

#PLEASE NOTE: If you're interested in working with the "sentiment" or "openNLP"
#packages, you may need to perform some extra steps in order to install and load
#them. I will to address these steps now.

#The "sentiment" package is no longer possesses a CRAN respository, so you will
#need to download the source code. "sentiment" also requires the loading of 
#"Rstem". 

install_url("http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")


#Required packages that need to be installed and loaded
require(sentiment)
require(openNLP)
require(twitteR)

#First let's load a clean data file. I'm going to load the clean McDonald's
#tweet text.
McDtext <- readLines("./CleanData/CleanMcDTweets.txt")

#Let us now try to perform some basic sentiment functions on the text. The
#classify_emotion() function resides in the "sentiment" package and takes in 
#a set of text and implements a naive Bayesian classifier. 

McDemotions <- classify_emotion(McDtext, algorithm = "bayes", prior = 1)

#McDemotions is now a data frame of log-likelihoods for each text instance
#The two hypotheses would be the null and the given sentiment. We would 
#want to maximize the likeliood, so the higher the value represents a better
#likelihood. If take a look, we can see what these sentiments are.
head(McDemotions)

#As one can tell, there are missing values in the BEST_FIT column, so we should
#remove these.

#We first grab the BEST_FIT column, however.
McDEmobestfit <- McDemotions[ , 7]
McDEmobestfit[is.na(McDEmobestfit)] <- "Unknown" 

#Now, let's take a look at the frequencies of the sentiments.
McDemofreq <- table(McDEmobestfit)
barplot(McDemofreq)

#We can also convert the columns with likelihoods into numeric
McDNumdf <- data.frame(Anger = as.numeric(McDemotions[, 1]),
                       Disgust = as.numeric(McDemotions[ , 2]),
                       Fear = as.numeric(McDemotions[ , 3]),
                       Joy = as.numeric(McDemotions[ , 4]),
                       Sadness = as.numeric(McDemotions[ , 5]),
                       Surprise = as.numeric(McDemotions[ , 6]))

summary(McDNumdf)

#We can take advantage of "sentiment" further by using the classify_polarity()
#function that classifies a given text as "negative", "positive" or "neutral".
#The output is another data frame of log-likelihoods.

McDPolar <- classify_polarity(McDtext, algorithm = "bayes")

#Again, we'll take a quick look
head(McDPolar)

#We will now grab the BEST_FIT column once again
McDPolbestfit <- McDPolar[ , 4]

#Next, let's compile the output into another data frame and view it.
McDSentiments <- data.frame (text = McDtext,
                             Emotion = McDEmobestfit,
                             Polarity = McDPolbestfit,
                             stringsAsFactors = FALSE)

View(McDSentiments)


