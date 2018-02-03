#load the required packages
library("tidyverse")
library("lubridate")
library("stringi")
library("grid")
library("scales")
library("NbClust")

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

#cluster the data
#try kmeans clustering
fit.km = kmeans(df[,2:8],4,nstart = 20)


df = df %>% 
  mutate(
    cluster = as.factor(fit.km$cluster)
  )

#make all the plots an put them on a single place
roll_plot = ggplot(df,aes(x=time_posix, color = cluster, y=Roll))+
  geom_point(size = 0.4)+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFx_plot = ggplot(df,aes(x=time_posix, color = cluster,y=gFx))+
  geom_point(size = 0.4)+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFy_plot = ggplot(df,aes(x=time_posix, color = cluster,y=gFy))+
  geom_point(size = 0.4)+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
gFz_plot = ggplot(df,aes(x=time_posix, color = cluster,y=gFz))+
  geom_point(size = 0.4)+
  scale_x_datetime(breaks= date_breaks("5 min"))+
  #theme_minimal() +
  theme(axis.title.x = element_blank())
pitch_plot = ggplot(df,aes(x=time_posix, color = cluster,y=Pitch))+
  geom_point(size = 0.4)+
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




