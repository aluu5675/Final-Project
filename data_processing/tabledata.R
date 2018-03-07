library("dplyr")
library("rvest")


# set-up of initial values
startyear <- 1920
endyear <- 2018



url_init <- "http://aviation-safety.net/database/dblist.php?Year="

# initiate empty dataframe, in which we will store the data
dat <- data.frame(date = numeric(0), type = numeric(0), registration = numeric(0),
                  operator = numeric(0), fatalities = numeric(0),
                  location = numeric(0), category = numeric(0))

for (year in startyear:endyear) {
  # get url for this year
  url_year <- paste0(url_init, year)
  
  # get max pages in current year
  pages <- url_year %>% read_html() %>%
    html_nodes(xpath = '//*[@id="contentcolumnfull"]/div/div[2]') %>%
    html_text() %>% strsplit(" ") %>% unlist() %>%
    as.numeric() %>% max()
  
  if(pages == -Inf) { #no pages, only one page for current year
    
    incidents <- url_year %>% read_html() %>%
      html_nodes("table") %>% #use CSS selector, not x-path
      html_table() %>% data.frame()
    
    #combine the data 
    dat <- rbind(dat,incidents)
 
   } else { #loop through pages of current year
     
     for (page in 1:pages) {
       url <- paste0(url_year,"&lang=&page=", page)
       
       # get the html data and convert it to a data.frame
       incidents <- url %>% read_html() %>%
         html_nodes(xpath = '//*[@id="contentcolumnfull"]/div/table') %>%
         html_table() %>% data.frame()
       
       # combine the data
       dat <- rbind(dat, incidents)
     }
  }
  
}

write.csv(dat, file = "dat.csv", row.names = FALSE)
