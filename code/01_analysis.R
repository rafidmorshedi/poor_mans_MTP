#load the required packages
library("tidyverse")
library("lubridate")
library("stringi")
library("grid")
library("scales")

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

#make all the plots an put them on a single place
roll_plot = ggplot(df,aes(x=time_posix,y=Roll))+
  geom_line()+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFx_plot = ggplot(df,aes(x=time_posix,y=gFx))+
  geom_line()+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFy_plot = ggplot(df,aes(x=time_posix,y=gFy))+
  geom_line()+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFz_plot = ggplot(df,aes(x=time_posix,y=gFz))+
  geom_line()+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
pitch_plot = ggplot(df,aes(x=time_posix,y=Pitch))+
  geom_line()+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
#initaliase the saving of the pdf
# filePath = "figs/signalsVsTime.pdf"
# pdf(filePath,width=11.69, height=8.27, paper='a4r')

#plot the results on a graph
grid.newpage()
grid.draw(rbind(ggplotGrob(roll_plot), 
                ggplotGrob(gFx_plot),
                ggplotGrob(gFy_plot),
                ggplotGrob(gFz_plot),
                ggplotGrob(pitch_plot),
                size = "last"))

# dev.off()




