
#####::::::::::::::::::::::::::Data Acquisition:::::::::::::::::::::::::::::::#####

#This file will go through the process of interacting with the TwitteR package in 
#order to collect tweets with a desired string pattern in it (ie. "McDonalds")


#First step is to install and load the necessary packages.
#Depending on your machine's setup, you may not need to install all of these.
#Don't forget to install.packages() before the loading them with the following 
#command statements.

require(base64enc)
require(httpuv)
require(httr)
require(rjson)
require(bit64)
require(dplyr)
require(devtools)
require(twitteR)

#Next, you'll need to sign up for a Twitter Devoloper's Account at the 
#following link: https://dev.twitter.com/

#Once you're all signed up and logged in, navigate to the app website at this link
#https://apps.twitter.com/

#After getting onto the App site, you should see a button in the upper right hand
#region that is labeled "Create New App". Click on the it, it will take you to a
#"Create an Application" page where you will have to fill out some basic 
#information fields about your app. Also, don't forget to agree to the 
#Terms & Conditions at the bottom of the page.

#Next how to access the key, secret, token and acess secret. 
#Need to tell users that this information is sensitive and should be kept private. 
#This block essentially allows R to search for Twee

setup_twitter_oauth(consumer_key = "*****", 
                    consumer_secret = "*****",
                    access_token = "*****",
                    access_secret = "*****")