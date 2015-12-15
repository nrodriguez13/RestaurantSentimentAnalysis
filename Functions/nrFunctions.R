
####::::::::::::::::::::::::::::::FUNCTIONS:::::::::::::::::::::::::::::::::::####
##The purpose of this script is to provide the functions that were created for 
##cleaning and analysis purposes.
#Author: Nick Rodriguez

#This function takes in as input a string that may possess excessive white space.
#The output will be that string with more natural white space.
trimWhiteSpaces <- function (x) gsub("^\\s+|\\s+$", "", x)

#tagPOS() is not found in the NLP packages, so this function is cited at
#http://stackoverflow.com/questions/28764056/could-not-find-function-tagpos
#The purpose of this function is to tag text input with parts of speech.
#We want to do this so we can look at the frequencies of certain adjectives
#and other types of words. 

#The input is a character vector or to be more specific, a vector of tweets.
#The output is a data frame of 2 rows and the number of columns depend on
#the length of the vector. The data frame tags the words in each string with
#its corresponding part of speech. The POS is attached via a backslash 
#character.
tagPOS <-  function(x, ...) {
  s <- as.String(x)
  word_token_annotator <- Maxent_Word_Token_Annotator()
  a2 <- Annotation(1L, "sentence", 1L, nchar(s))
  a2 <- annotate(s, word_token_annotator, a2)
  a3 <- annotate(s, Maxent_POS_Tag_Annotator(), a2)
  a3w <- a3[a3$type == "word"]
  POStags <- unlist(lapply(a3w$features, `[[`, "POS"))
  POStagged <- paste(sprintf("%s/%s", s[a3w], POStags), collapse = " ")
  list(POStagged = POStagged, POStags = POStags)
}


#This function will parse out the POS that are tagged to each word of a 
#character vector. It will then plot a frequency table of all the POS. 
#The input for this function is actually the data frame that one would 
#receive after using tagPOS(). Again, the output is a barplot of 
#POS frequencies.
posFreqPlot <- function(x) {
  taggedList <- strsplit(as.character(x[1,]), split = " ")
  taggedVec <- unlist(taggedList)
  splitVec <- unlist(strsplit(taggedVec[1:length(taggedVec)], split = "/"))
  allTags <- splitVec[seq(from = 2, to = length(splitVec), by = 2)]
  tagFreqs <- table(allTags)
  plotTitle <- gsub("TagsDF", "", deparse(substitute(x)))
  barplot(tagFreqs, main = paste("Frequency of POS in ", plotTitle, " Tweets"),
          xlab = "Parts of Speech", ylab = "Frequency")
}



