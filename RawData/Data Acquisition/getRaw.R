setwd("./Desktop/STAT\ 133/proj/")

require(base64enc)
require(httpuv)
require(httr)
require(rjson)
require(bit64)
require(dplyr)
require(devtools)
require(twitteR)

setup_twitter_oauth(consumer_key = "EVhXjwPqxQhWYa7Mjx4nUbCxu", 
                    consumer_secret = "wjlEVUO6q1WEsZe77zTth8SJISU2IhH1eGjUTe4XQTkFlw0xcn",
                    access_token = "1663337618-BqWwzDbBii9RdTdd9BCcUxomf9vR6FGQ6VVIfDq",
                    access_secret = "YiIhfDKFK93SW0cslX9CefxKCMQLkbSqsjNGJrTgjfCXQ")
InNOut_sample <- searchTwitter(searchString = "to:innoutburger", n = 200, lang = "en")
InNOut_DF <- twListToDF(InNOut_sample)
write.table(InNOut_DF, file = "./RawData/InNOut_tweets.txt")
