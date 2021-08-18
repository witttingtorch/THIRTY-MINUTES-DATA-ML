library(magrittr)
library(readr)
library(dplyr)
library(sjmisc)
library (tidyverse)
library(lubridate)
library(ggplot2)
bike<- readr::read_csv("train.csv")
str(bike)
duplicates<-duplicated(bike)#looking for duplicates in the dataset
table(duplicates)
bike%>%sjmisc::descr()->desr_stats
readr::write_csv(desr_stats,"descriptive.csv")
#Exploring Categorical variables
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

