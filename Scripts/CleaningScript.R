
####::::::::::::::::::::::::::::Cleaning Script:::::::::::::::::::::::::::::::####
#### This script will go through cleaning process of text data from tweets.

#First we load up the text file into a data frame.
McDDF <- read.table(file = "./RawData/RawMcDTweets.txt", 
                    header = FALSE, fill = TRUE)

#Next, we will grab the column that holds the tweets' text
McDtweets <- McDDF$V2

#McDtweets <- sapply(McDtweets, function(x) x$getText())

#Get rid of annoying retweet instances
McDtweets <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", McDtweets)

#Get rid of Twitter handles
McDtweets <- gsub("@\\w+", "", McDtweets)

#Deleting punctuation 
McDtweets <- gsub("[[:punct:]]", "", McDtweets)

# remove numbers
McDtweets <- gsub("[[:digit:]]", "", McDtweets)

# remove html links
McDtweets <- gsub("http\\w+", "", McDtweets)

#get rid of emojis
McDtweets <- sapply(McDtweets, function(row) iconv(row, "latin1", "ASCII", sub = ""))
names(McDtweets) <- NULL
McDtweets <- unique(McDtweets)


#gets rid of extra spacing (Both leading and trailing white spaces)
trimWhiteSpaces <- function (x) gsub("^\\s+|\\s+$", "", x)
McDtweets <- trimWhiteSpaces(McDtweets)

#Check for any NA instances
McDtweets[is.na(McDtweets)]

#lower case all tweets
McDtweets <- sapply(McDtweets, tolower)
names(McDtweets) <- NULL
McDtweets <- unique(McDtweets)

#Export data to a file in the CleanData directory.
write(McDtweets, file = "./CleanData/CleanMcDTweets.txt")
