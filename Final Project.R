# For Data-Wrangling
library(dplyr)
library(stringr)


passenger.info <- read.csv("data/passenger_info.csv", stringsAsFactors = FALSE)
dat <- read.csv("data/dat.csv", stringsAsFactors = FALSE)


data_year <- dat
data_year$year <- str_sub(data_year$date, -4, -1)
passenger.info$year <- sapply(passenger.info$year, as.character)

#same thing but year column attached MAIN data frame
data_year <- left_join(data_year, passenger.info, by = c("year" = "year"))
write.csv(data_year, file = "data/mapvalues.csv", row.names = FALSE)

#includes fatality average for each year and actual fatality number
# ratio is occurence of crash / fatality
data_year_general <- group_by(data_year, year) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

#only military
data_year_military <- filter(data_year, str_detect(operator, fixed("AF")) |
                               str_detect(operator, fixed("Navy")) |
                               str_detect(operator, fixed("Army")) |
                               str_detect(operator, fixed("Air Force")))

# group by military operator
summary_year_military_operator <- group_by(data_year_military, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

#type of military aircraft
summary_year_military_plane <- group_by(data_year_military, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))


# only contains private operators
data_year_private <- filter(data_year, operator == "private" |
                              operator == "Private")

#summary of private operators
summary_year_private_operator <- group_by(data_year_private, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

# not nessesary
summary_year_private_plane <- group_by(data_year_private, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

# remove miliatary and private operators, so only other airlines
data_year_ex_military <- setdiff(data_year, data_year_military)
data_year_other <- setdiff(data_year_ex_military, data_year_private)



# other
data_year_other_ratio <- group_by(data_year_other, year) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)),
            ratio = 100 * total_fatality / passenger[1] )

summary_year_other <- group_by(data_year_other, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

summary_year_other_plane <- group_by(data_year_other, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

#UPDATED PRIVATE TABLE: CONTAINS YEAR AND DATE AND MODEL NAME.
summary_year_private_year <- summary_year_private_plane %>% 
  left_join(data_year_private, by = "type") %>% 
  select(date, type, 
         total_occurence,
         total_fatality,
         average_fatality, 
         location, 
         year)


#UPDATED MILITARY TABLE: CONTAINS YEAR AND DATE AND MODEL NAME.
summary_year_military_year <- left_join(summary_year_military_plane, 
                                        data_year_military, by ="type") %>%  
  select(date, type, 
         total_occurence,
         total_fatality,
         average_fatality, 
         location, 
         year)

#UPDATED OTHER PLANE TABLE: CONTAINS YEAR AND DATE AND MODEL NAME.
summary_year_other_year <- summary_year_other_plane %>% 
  left_join(data_year_other) %>% 
  select(date, type, 
         total_occurence,
         total_fatality,
         average_fatality, 
         location, 
         year)

#UPDATED OVERALL TABLE
data_updated <- data_year 
colnames(data_updated)[colnames(data_updated) == "fat."] <- "total_fatality"
data_updated[7:8] <- NULL

# data_month <- dat
# data_month$date <- str_sub(data_month$date, 4, 6)

