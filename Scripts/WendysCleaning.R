####::::::::::::::::::::::::::::Cleaning Script:::::::::::::::::::::::::::::::####
#### This script will go through cleaning process of text data from tweets. 

#First we load up the text file into a data frame.
WendysDF <- read.table(file = "./RawData/WendysTweets.txt", 
                    header = FALSE, fill = TRUE)

#Next, we will grab the column that holds the tweets' text
WendysTweets <- WendysDF$V2

#Get rid of annoying retweet instances
WendysTweets <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", WendysTweets)

#Get rid of Twitter handles
WendysTweets <- gsub("@\\w+", "", WendysTweets)

#Deleting punctuation 
WendysTweets <- gsub("[[:punct:]]", "", WendysTweets)

# remove numbers
WendysTweets <- gsub("[[:digit:]]", "", WendysTweets)

# remove html links
WendysTweets <- gsub("http\\w+", "", WendysTweets)

#get rid of emojis
WendysTweets <- sapply(WendysTweets, function(row) iconv(row, "latin1", "ASCII", sub = ""))
names(WendysTweets) <- NULL
WendysTweets <- unique(WendysTweets)


#gets rid of extra spacing (Both leading and trailing white spaces)
trimWhiteSpaces <- function (x) gsub("^\\s+|\\s+$", "", x)
WendysTweets <- trimWhiteSpaces(WendysTweets)
WendysTweets = gsub("\\n", " ", WendysTweets)

#Check for any NA instances
WendysTweets[is.na(WendysTweets)]

#lower case all tweets
WendysTweets <- sapply(WendysTweets, tolower)
names(WendysTweets) <- NULL
WendysTweets <- unique(WendysTweets)

#Export data to a file in the CleanData directory.
write(WendysTweets, file = "./CleanData/CleanWendysTweets.txt")
