#Restaurant Sentiment Analysis

###Project Description

This project attempts to gain a glimpse of the sentiments of some fast food
restaurants. Sentiments are measured using methods from the **sentiment**
package on a sample of tweets about the restaurants in question. The
restaurants that were used were **McDonald's**, **Wendy's**, **Ben & Jerry's**
and **In-n-Out Burger**.

With that said, this small project works with the **twitteR** package as well,
where one can submit queries to the Twitter API through R. To get started, I
suggest navigating to the **RawData** directory and beginning with
the **DataAcquistion** file which will be in the *DataAcquistion* subdirectory.
The file will assist with set up. This includes: loading necessary packages,
signing up for a Twitter Dev's account, authenticating a session with Twitter
in R and submitting queries for tweets.

###The Team

**Nicolas Rodriguez**: A Cognitive Science major.

**Navya Putta**: A graduating Statistics major.

**Bret Hart**: A Mathematics major.

**Yea (Anna) Jung**: A junior Computer Science major.

###The Setup

You should find that there are 6 directories:

    - RawData
    - CleanData
    - Scripts
    - Plots
    - Functions
    - Report

In the *RawData* directory, again, you will find a **DataAcquistion** file that
assist you with getting started with the *twitteR* package. The directory will
also house the data we compiled for our specific project (in case you want
to take a look). You will find data files for the different restaurants:
**McDonald's**, **Wendy's**, **Ben & Jerry's** and **In-n-Out Burger**. The
raw data is in the form when we extract it from the **twitteR** package with
the *searchTwitter()* method.

The *CleanData* directory, like the clever title implies, holds the clean data
files that we later analyze and visualize. You will find data files for the
different restaurants: **McDonald's**, **Wendy's**, **Ben & Jerry's** and
**In-n-Out Burger**.

The *Scripts* directory holds the R scripts that cleans the data and
implements exploratory data analysis and generate plots. Feel free to
walk through the script, command statements are for the most part narrated.

The *Plots* directory houses the EDA plots and more in depth visualizations
like a word frequencies bar plot and word clouds. The plots were created with
the basic *barplot()* function and *ggplot()* functions.

The *Functions* directory contains a script of three functions that were
required for our analysis. The functions' purposes range from clean up to
data transformation to plotting.

The *Report* directory holds documents that contain our write up of the
project. There is a PDF version included that shows the final version that
was ultimately submitted.

###Some Useful Links

I found these resources very helpful.
  - [Twitter Search API](https://dev.twitter.com/rest/public/search)
  - [Regular Expressions Cheat Sheet](http://www.cheatography.com/davechild/cheat-sheets/regular-expressions/)
  - [Sentiment for Consumer Analysis](http://colinpriest.com/2015/07/04/tutorial-using-r-and-twitter-to-analyse-consumer-sentiment/)
  - [Basics of Text Mining](https://rstudio-pubs-static.s3.amazonaws.com/31867_8236987cf0a8444e962ccd2aec46d9c3.html)
