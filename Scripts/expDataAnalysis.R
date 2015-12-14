
####::::::::::::::::::::::Exploratory Data Analysis::::::::::::::::::::::::::####
#This scripts attempts to gain a glimpse of the data's behavior. We will perform
#sentiment analysis, take at look at word frequencies and some other summary
#statistics.

#PLEASE NOTE: If you're interested in working with the "sentiment" or "openNLP"
#packages, you may need to perform some extra steps in order to install and load
#them. I will to address these steps now.

#The "sentiment" package no longer possesses a CRAN respository, so you will
#need to download the source code. "sentiment" also requires the "Rstem" 
#to be loaded. Please run the following two lines that are commented out.
#Keep in mind, you only need to run these two install_URL commands once.

#install_url("http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
#install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")


#Required packages that need to be installed and loaded
require(ggplot2) #DO NOT LOAD THIS UNTIL YOU'RE DONE WITH TAGPOS()
require(sentiment)
require(openNLP)
require(stringr)

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
pdf(file = "./Plots/emotionFreq.pdf")
barplot(McDemofreq, main = "Frequencies of McDonald's Tweet Sentiments",
        xlab = "Sentiment", ylab = "Frequency")
dev.off()

png(file = "./Plots/emotionFreq.png", width = 480, height = 300)
barplot(McDemofreq, main = "Frequencies of McDonald's Tweet Sentiments",
        xlab = "Sentiment", ylab = "Frequency")
dev.off()

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
McDSentiments <- data.frame(text = McDtext,
                            Emotion = McDEmobestfit,
                            Polarity = McDPolbestfit,
                            stringsAsFactors = FALSE)

View(McDSentiments)

#Let's take take a look the McDSentiments even closer
length(McDSentiments$Emotion[McDSentiments$Emotion == "Unknown"])

#How many entries are classified as joyful?
length(McDSentiments$Emotion[McDSentiments$Emotion == "joy"])

#How many entries are classified as angry?
length(McDSentiments$Emotion[McDSentiments$Emotion == "anger"])

#How many entries are classified as disgust?
length(McDSentiments$Emotion[McDSentiments$Emotion == "disgust"])

#How many entries are classfied as sad?
length(McDSentiments$Emotion[McDSentiments$Emotion == "sadness"])

#How many entries are classified with a positive polarity?
length(McDSentiments$Polarity[McDSentiments$Polarity == "positive"])

#How many entries are classified with a negative polarity?
length(McDSentiments$Polarity[McDSentiments$Polarity == "negative"])

#How many entries are classified with a neutral polarity?
length(McDSentiments$Polarity[McDSentiments$Polarity == "neutral"])

fearTweets <- McDSentiments$text[McDSentiments$Emotion == "fear"]
sadTweets <- McDSentiments$text[McDSentiments$Emotion == "sadness"]
disgustTweets <- McDSentiments$text[McDSentiments$Emotion == "disgust"]
surprisedTweets <- McDSentiments$text[McDSentiments$Emotion == "surprise"]

#WARNING: This tagPOS() commands are little sensitive and are prone to a
#out of memory error. If you plan to tag many strings, you may need to break
#the vector into smaller ones. Another thing you could do is to relieve the 
#R environment by removing some values or unneeded data. Furthermore, 
#tagPOS() will have the tendency to have a cannot coerce class error. 
#The cause of this error is not straightforward I suggest either: restarting
#R or your computer, refraining to load NLP package more than once in one 
#session and don't load ggplot2 package until your done with using tagPOS()
unknownTweets <- McDSentiments$text[McDSentiments$Emotion == "Unknown"]
unknownTags1to30 <- sapply(unknownTweets[1:30], FUN = tagPOS)
unknownTags31to60 <- sapply(unknownTweets[31:60], FUN = tagPOS)
unknownTags61to90 <- sapply(unknownTweets[61:90], FUN = tagPOS)
unknownTags91to110 <- sapply(unknownTweets[91:110], FUN = tagPOS)
unknownTags111to120 <- sapply(unknownTweets[111:120], FUN = tagPOS)
unknownTags121to135 <- sapply(unknownTweets[121:135], FUN = tagPOS)

#Now we will recombine all the unknown tweet's POS tags into one data frame.
unknownTagsDF <- cbind(unknownTags1to30,
                       unknownTags31to60,
                       unknownTags61to90,
                       unknownTags91to110,
                       unknownTags111to120,
                       unknownTags121to135)

#Since the tagPOS() is prone to such an error and in case you attempt to run
#the blocks of code above and are unsuccessful, I have saved the output from
#successful implementations in the "unknownTagsDF" file under the 
#CleanData directory.

write.table(unknownTagsDF, file = "./CleanData/unknownTagsDF.txt")

#Now we can take a look at the frequencies of POS in tweets that are classified
#with an emotion of "Unknown". We will also save the plot to a PDF and PNG file.
pdf(file = "./Plots/unknownPOSFreq.pdf")
posFreqPlot(unknownTagsDF)
dev.off()

png(file = "./Plots/unknownPOSFreq.png", width = 480, height = 300)
posFreqPlot(unknownTagsDF)
dev.off()

#We can visualize the similar plots but on the other emotions (ie. joy). However
#we will need to rerun the tagPOS() on the corresponding set of tweets. 
joyfulTweets <- McDSentiments$text[McDSentiments$Emotion == "joy"]
joyfulTags1to20 <- sapply(joyfulTweets[1:20], tagPOS)
joyfulTags21to41 <- sapply(joyfulTweets[21:41], tagPOS)
joyfulTagsDF <- cbind(joyfulTags1to20, joyfulTags21to41)
write.table(joyfulTagsDF, file = "./CleanData/joyfulTagsDF.txt")

View(joyfulTagsDF)

pdf(file = "./Plots/joyfulPOSFreq.pdf")
posFreqPlot(joyfulTagsDF)
dev.off()

png(file = "./Plots/joyfulPOSFreq.png", width = 480, height = 300)
posFreqPlot(joyfulTagsDF)
dev.off()

#As one can tell, the dominant POS that is found seem to be nouns. You can take
#a look to see what these POS codes signify by looking at this link:
#http://cs.nyu.edu/grishman/jet/guide/PennPOS.html


angryTweets <- McDSentiments$text[McDSentiments$Emotion == "anger"]
angryTagsDF <- sapply(angryTweets, tagPOS)

#Now, let's see if we can plot word frequencies, in order to do this, I want
#to create a list of the files I have in a certain directory.
McDCorpus <- Corpus(DirSource(dirname(path = "./CleanData/CleanMcDTweets.txt")))

#I attempt to get rid of frequent words that are not of interest (ie. "and", "a")
McDCorpus <- tm_map(McDCorpus, removeWords, stopwords("english"))  

#Now I create a Document Term Matrix of part of the list I created earlier.
#I use the first index only because that corresponds to the CleanMcDTweets.txt
#file. 
McDDtm <- DocumentTermMatrix(McDCorpus[1])
#Next, I create a table of word frequencies
freqDF <- colSums(as.matrix(McDDtm))
#Let us take a look at the frequency table.
head(freqDF)
tail(freqDF)
#As one can tell, the words are ordered in alphabetical order.
#Next, we can attempt to remove sparse terms.
McDDtm <- removeSparseTerms(McDDtm, 0.1)
#Let us inspect the whole Document Term Matrix in full
inspect(McDDtm)

#Next we see the least and most frequent used terms.
freqDF[head(order(freqDF))]
freqDF[tail(order(freqDF))]

#We can also get a frequency table of frequencies
table(freqDF)

#Let us reorganize the Matrix so that frequencies will be in decreasing order
freqDF <- sort(colSums(as.matrix(McDDtm)), decreasing = TRUE)  

#Now we can try to create a plot
plotFreqDF <- data.frame(word = names(freqDF), frequency = freqDF)
head(plotFreqDF)

McDWordplot <- ggplot(subset(plotFreqDF, frequency > 5), aes(word, frequency))    
McDWordplot <- McDWordplot + geom_bar(stat = "identity")   
McDWordplot <- McDWordplot + theme(axis.text = 
                                     element_text(angle = 40, hjust = 1))   
pdf(file = "./Plots/McDWordFreqPlot.pdf")
McDWordplot
dev.off()

png(file = "./Plots/McDWordFreqPlot.png")
McDWordplot
dev.off()

