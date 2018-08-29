

# Question #1
#-------------
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "df26b7c52c2c2e7b769c",
                   secret = "8717f7eaba02a294a23451ac6eace83498889174")

# 3. Get OAuth credentials
github_token <- oauth1.0_token(oauth_endpoints("github"), myapp) # use oauth1.0 - not 2.0
# if wanting to use oauth2.0 append 'redirect_uri = "http://localhost:1410"'

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
leek_repo <- content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

### studying the data, we know this is a list of lists


# convert to json in order to read the list
json1 = jsonlite::fromJSON(toJSON(leek_repo))
json1[json1$name == "datasharing", ]$created_at

# Question #2
#-------------

acs <- fread("getdata%2Fdata%2Fss06pid.csv")

# Which of the following commands will select only the data 
# for the probability weights pwgtp1 with ages less than 50?
sqldf("select pwgtp1 from acs where AGEP < 50")

# Question #3
#-------------
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

# Question #4
#-------------
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page


connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
nchar(htmlCode[c(10,20,30,100)])

# 5. Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

# (Hint this is a fixed width file format)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])
