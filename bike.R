#LIBRARIES 
library(magrittr)
library(readr)
library(dplyr)
library(sjmisc)
library (tidyverse)
library(lubridate)#for date manipulation
library(ggplot2) #for data visualization
#LOADING DATA AND DESCRIPTIVES
bike<- readr::read_csv("train.csv")
#Displaying the structure of the data
str(bike)
#Descriptives statistics
duplicates<-duplicated(bike)#looking for duplicates in the dataset
table(duplicates)
bike%>%sjmisc::descr()->desr_stats
readr::write_csv(desr_stats,"descriptive.csv")
#Exploring Categorical variables
bike%>%count(Seasons,sort = TRUE)
dplyr::count(bike,dplyr::n_distinct("bike$seasons"))
bike_category <-bike[,sapply(bike,class)=='character']
bike_category%>%dplyr::summarise_all(dplyr::funs(dplyr::n_distinct(.)))
#VISUALIZING THE DATA 
#with grid
bike%>%ggplot(aes(x=y,y=Seasons))+geom_jitter(size=.5,alpha=.5,color="purple")+labs(title = "Relationship of seasons with bike counts" ,x="BIKE COUNT",y="SEASONS")#with a gridbike%>%ggplot(aes(x=y,y=Seasons))+geom_jitter(size=.5,alpha=.5,color="purple")+labs(title = "Relationship of seasons with bike counts" ,x="BIKE COUNT",y="SEASONS")+theme(panel.grid = element_blank())
#without grid
bike%>%ggplot(aes(x=y,y=Seasons))+geom_jitter(size=.5,alpha=.5,color="purple")+labs(title = "Relationship of seasons with bike counts" ,x="BIKE COUNT",y="SEASONS")+theme(panel.grid = element_blank())
#HOLIDAY
bike%>%ggplot(aes(x=y,y=Holiday))+geom_jitter(size=.5,alpha=.5,color="purple")+labs(title = "Relationship of seasons with bike counts" ,x="BIKE COUNT",y="HOLIDAY")+theme(panel.grid = element_blank())
bike%>%ggplot(aes(y,Hour,colour=Seasons))+geom_point()
bike%>%group_by(bike$Date,bike$y)%>%summarise(bike$y=n())+
  ggplot(aes(x=bike$Date,y=bike$y))+
  geom_jitter(aes(size=.5,alpha=.5,color="lightblue")+
                labs(title = "BIKE COUNT ACCORDING WITH DATES",x="weeks",y="Bikecount")+theme(panel.grid = element_blank()))

