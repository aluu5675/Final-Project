
original_country_year <- read.csv("data/passenger.csv", stringsAsFactors = FALSE, skip = 4)

passenger <- c()
year <- c()

for (col in 17 : ncol(original_country_year) - 2) {
  
  sum <- sum(as.numeric(original_country_year[, col]), na.rm = T)
  passenger <- append(passenger, sum)
  year <- append(year, colnames(original_country_year)[col])
  

}

passenger.info <- data.frame(year, passenger)
passenger.info$year <- gsub("X", "", passenger.info$year)
# passenger.info$year <- sapply("X", gsub, "" , passenger.info$year)
View(passenger.info)