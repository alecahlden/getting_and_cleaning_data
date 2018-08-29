## API Notes

# 1. create an account with the dev account to get the API info (Twitter example)
# 2. load httr package

library(httr)

myapp = oauth_app("twitter", key = "WIIerK4fc3PgLtIuH9Nk5hupH", 
                  secret = "R9n3N1A5ZPlmX9k7cC7n7tH7bLcr7ZkVwEoh34J9MNGBpKV8Rb")

sig = sign_oauth1.0(myapp, token = "207320673-i1zcK079hT90O7dVqGCvHFZYktYAdad8vDdooKR7", 
                              token_secret = "fSuCEHcGy3a3G3NtFmPXnDbAYsf1odQmjKwMljUecfqoR")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

install.packages("RJSONIO")
install.packages("jsonlite")
library(RJSONIO)
json1 = content(homeTL) # little hard to read
json2 = jsonlite::fromJSON(toJSON(json1)) # use jsonlite package to convert back to df
# each row corresponds to a tweet on a timeline
json2[1, 1:4]

# httr allows GET, POST, PUT, DELETE requests (if authorized)
# httr works well with Facebook, Google, Twitter, Github, etc.
  # go to httr demo on Github to see examples of how you access different APIs

