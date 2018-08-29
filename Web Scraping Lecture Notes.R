

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con) # always close the connection
htmlCode

# parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en" # maybe https://
html <- htmlTreeParse(url, useInternalNodes = T)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# httr package
library(httr); html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# access websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd")) # actually input user/pass
pg2
names(pg2)

# using handles
google= handle("http://google.com")
pg1 = GET(handle=google, path = "/")
pg2 = GET(handle = google, path = "search")
