library(rvest)
library(dplyr)

startyear <- 1940
endyear <- 1945

url_init <- "http://aviation-safety.net/database/dblist.php?Year="

# initiate empty dataframe, in which we will store the data
dat <- data.frame(date = numeric(0), type = numeric(0), registration = numeric(0),
                  operator = numeric(0), fatalities = numeric(0),
                  location = numeric(0), category = numeric(0))

for (year in startyear:endyear){
  # get url for this year
  url_year <- paste0(url_init, year)
  
  # get pages
  pages <- url_year %>% html() %>%
    html_nodes(xpath = '//*[@id="contentcolumnfull"]/div/div[2]') %>%
    html_text() %>% strsplit(" ") %>% unlist() %>%
    as.numeric() %>% max()
  
  # loop through the pages
  for (page in 1:pages){
    url <- paste0(url_year,"&lang=&page=", page)
    
    # get the html data and convert it to a data.frame
    incidents <- url %>% html() %>%
      html_nodes(xpath = '//*[@id="contentcolumnfull"]/div/table') %>%
      html_table() %>% data.frame()
    
    # combine the data
    dat <- rbind(dat, incidents)
  }
}
