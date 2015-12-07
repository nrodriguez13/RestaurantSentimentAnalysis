
#####::::::::::::::::::::::::::Data Acquisition:::::::::::::::::::::::::::::::#####

#This file will go through the process of interacting with the TwitteR package in 
#order to collect tweets with a desired string pattern in it (ie. "McDonalds")



#####::::::::::::::::::::::::::Required Packages::::::::::::::::::::::::::::::####

#First step is to install and load the necessary packages.
#Depending on your machine's setup, you may not need to install all of these.
#Don't forget to install.packages() before the loading them with the following 
#command statements if you haven't already.

require(base64enc)
require(httpuv)
require(httr)
require(rjson)
require(bit64)
require(dplyr)
require(devtools)
require(twitteR)

#Next, you'll need to sign up for a Twitter Devoloper's account at the 
#following link --->  https://dev.twitter.com/

#Once you're all signed up and logged in, navigate to the app website at this 
#link --->  https://apps.twitter.com/

#After getting onto the App site, you should see a button in the upper right hand
#region that is labeled "Create New App". Click on the it, it will take you to a
#"Create an Application" page where you will have to fill out some basic 
#information fields about your app. Also, don't forget to agree to the 
#Terms & Conditions at the bottom of the page. Finally, click on the Create 
#button that is also at the bottom.

#You should now be on the page for the application you just created. Under the 
#header (the title for your app), you'll find some tabs. You will want to click 
#on the tab that is labeled "Keys and Access Tokens".

#The pieces of information you will need in order to authenticate a session 
#with the TwitteR package are the Consumer Key, Consumer Secret, Access Token
#and Access Token Secret. The first two should already be on the page after you 
#clicked on the tab. In order to gain the Access Token and Access Token Secret,
#you need to click the button toward the bottom of the page that is labeled 
#"Create my access token". The last two pieces of information will then be 
#generated. 

#Now that you have all that information, we can now set up a session with Twitter
#here in R. Please keep in mind that this type of information is sensitive, and 
#should not be shared. With that said, I will not expose my tokens. 

#Here I provided the setup_twitter_oauth() function command call, simply
#substitute the asterisk symbols with your tokens and keys. Make sure you
#maintain the strings, in other words do not delete the quotes. 

setup_twitter_oauth(consumer_key = "*****", 
                    consumer_secret = "*****",
                    access_token = "*****",
                    access_secret = "*****")

#Now run the command once all your information is in the proper places. You will
#will then be queried: "Use a local file to cache OAuth access credentials 
#between R sessions?"
#You should respond with 1, meaning Yes. If all goes well, you are now ready to
#interact with Twitter 

####:::::::::::::::::::::::::::Getting Tweets::::::::::::::::::::::::::::::::####

#In order to search for 

tweetsample <- searchTwitter(searchString = "@google since:2015-12-06", 
                             n = 50, lang = "en")


