# For Data-Wrangling
library(dplyr)
library(stringr)
library(plotly)
source("tabledata.R")

passenger.info <- read.csv("data/passenger_info.csv", stringsAsFactors = FALSE)
dat <- read.csv("data/dat.csv", stringsAsFactors = FALSE)

data_year <- dat
data_year$year <- str_sub(data_year$date, -4, -1)

data_year <- left_join(data_year, passenger.info, by = c("year" = "year"))

data_year_general <- group_by(data_year, year) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

data_year_military <- filter(data_year, str_detect(operator, fixed("AF")) |
                                        str_detect(operator, fixed("Navy")) | 
                                        str_detect(operator, fixed("Army")) | 
                                        str_detect(operator, fixed("Air Force")))

summary_year_military_operator <- group_by(data_year_military, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

summary_year_military_plane <- group_by(data_year_military, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))



data_year_private <- filter(data_year, operator == "private" |
                                       operator == "Private")

summary_year_private_operator <- group_by(data_year_private, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

summary_year_private_plane <- group_by(data_year_private, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))


data_year_ex_military <- setdiff(data_year, data_year_military)
data_year_other <- setdiff(data_year_ex_military, data_year_private)

data_year_other_ratio <- group_by(data_year_other, year) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)),
            ratio = 100 * total_fatality / passenger.info[1])

summary_year_other <- group_by(data_year_other, operator) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))

summary_year_other_plane <- group_by(data_year_other, type) %>%
  summarize(total_occurence = sum(occurence),
            total_fatality = sum(as.numeric(fat.), na.rm = T),
            average_fatality = mean(round(total_fatality / total_occurence, digits = 2)))


# data_month <- dat
# data_month$date <- str_sub(data_month$date, 4, 6)
source('ui.r')
source('server.r')
shinyApp(ui = ui, server = server)

