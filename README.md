# Restaurant Sentiment Analysis

###Project Description

This project attempts to gain a glimpse of certain region's sentiments of
some fast food restaurants. Sentiments are measured using methods from
the *sentiment* package on a sample of tweets about the restaurants in
question.

With that said, this small project works with the *twitteR* package as well,
where one can submit queries to the Twitter API through R. To get started, I
suggest navigating to the **RawData** directory and beginning with
the **DataAcquistion** file. The file will assist with set up. This includes:
loading necessary packages, signing up for a Twitter Dev's account,
authenticating a session with Twitter in R and submitting queries for tweets.

###The Team

**Nicolas Rodriguez**: A Cognitive Science major interested in UX research.

**Navya Putta**:

**Bret Hart**:

**Yea (Anna) Jung**:

###The Setup

You should find that there are 5 directories:

    - RawData
    - CleanData
    - Scripts
    - Plots
    - Functions

In the *RawData* directory, again, you will find a **DataAcquistion** file that
assist you with getting started with the *twitteR* package. The directory will
also house the data we compiled for our specific project (in case you want
to take a look).

The *CleanData* directory, like the clever title implies, holds the clean data
files that we later analyze and visualize.

The *Scripts* directory holds the R scripts that cleans the data. Feel free to
walk through the script, command statements are for the most part narrated.

###Some Useful Links

I found these resources very helpful.
  - [Twitter Search API](https://dev.twitter.com/rest/public/search)
