#load the required packages
library("tidyverse")
library("lubridate")
library("stringi")

options(digits = 12)
options(digits.secs = 3)

#load the data
df_raw = read_csv("data/2018-01-2418.13.09.csv")

#add the date
df = df_raw %>% mutate(
  time = stri_replace_last_fixed(time,":","."),
  time = paste("2018-01-24",time),
  time_posix = as_datetime(time,tz = "Australia/Sydney")
)


ggplot(df,aes(x=time_posix,y=Azimuth))+geom_line()
