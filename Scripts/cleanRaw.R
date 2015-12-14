setwd("./Desktop/STAT\ 133/proj/")

####::::::::::::::::::::::::::::Cleaning Script:::::::::::::::::::::::::::::::####
#### This script will go through cleaning process of text data from tweets. 

#First we load up the text file into a data frame.
InNOut_DF <- read.table(file = "./RawData/InNOut_Tweets.txt", 
                    header = FALSE, fill = TRUE)

#Next, we will grab the column that holds the tweets' text
InNOut_tweets <- InNOut_DF$V2

#McDtweets <- sapply(McDtweets, function(x) x$getText())

#Get rid of annoying retweet instances
InNOut_tweets <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", InNOut_tweets)

#Get rid of Twitter handles
InNOut_tweets <- gsub("@\\w+", "", InNOut_tweets)

#Deleting punctuation 
InNOut_tweets <- gsub("[[:punct:]]", "", InNOut_tweets)

# remove numbers
InNOut_tweets <- gsub("[[:digit:]]", "", InNOut_tweets)

# remove html links
InNOut_tweets <- gsub("http\\w+", "", InNOut_tweets)

#get rid of emojis
InNOut_tweets <- sapply(InNOut_tweets, function(row) iconv(row, "latin1", "ASCII", sub = ""))
names(InNOut_tweets) <- NULL
InNOut_tweets <- unique(InNOut_tweets)


#gets rid of extra spacing (Both leading and trailing white spaces)
trimWhiteSpaces <- function (x) gsub("^\\s+|\\s+$", "", x)
InNOut_tweets <- trimWhiteSpaces(InNOut_tweets)

#Check for any NA instances
InNOut_tweets[is.na(InNOut_tweets)]

#lower case all tweets
InNOut_tweets <- sapply(InNOut_tweets, tolower)
names(InNOut_tweets) <- NULL
InNOut_tweets <- unique(InNOut_tweets)

#Export data to a file in the CleanData directory.
write(InNOut_tweets, file = "./CleanData/InNOut_tweets.txt")
