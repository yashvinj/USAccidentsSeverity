library(ggplot2)
library(tidyverse)
library(data.table)
library(modelr)
library(RColorBrewer)
library(lubridate)

getwd()
setwd("C://Users//yashv//OneDrive//Desktop")
table_f<-fread("us_accidents.csv")
memory.limit(size=56000)
options(scipen = 999)
accidents_tibble<-as_tibble(table_f)


#Finding accidents and severity by Year
accidents_tibble<-accidents_tibble %>%
  mutate(Year=year(accidents_tibble$End_Time))

accidents_tibble$Year

year_data<-accidents_tibble %>%
  filter(Year==2016 | Year==2017 | Year==2018 | Year==2019) %>%
  group_by(Severity,Year) %>%
  count()

year_data %>%
  ggplot(aes(x=Year,y=n, group=Severity, color=as.factor(Severity)))+
  geom_line()+geom_point()+
  labs(title="Severity of Accidents over the Years", x="Year", y="Number of Accidents", color="Severity")


#substituting precipitation NA values with mean precipitation values

accidents_tibble$`Precipitation(in)` <- ifelse(is.na(accidents_tibble$`Precipitation(in)`), mean(accidents_tibble$`Precipitation(in)`, na.rm=TRUE), accidents_tibble$`Precipitation(in)`)
accidents_tibble$`Precipitation(in)`

#plotting severity vs precipitation
accidents_tibble %>%
  ggplot(aes(x=as.factor(Severity), y=`Precipitation(in)`))+geom_boxplot(stat= "boxplot")+labs(title="Severity vs Precipitation", x= 'Severity' ,y='Precipitation (in)')
 


#replace NA windspeed values with mean wind speed values
  

accidents_tibble$`Wind_Speed(mph)` <- ifelse(is.na(accidents_tibble$`Wind_Speed(mph)`), mean(accidents_tibble$`Wind_Speed(mph)`, na.rm=TRUE), accidents_tibble$`Wind_Speed(mph)`)

accidents_tibble$`Wind_Speed(mph)`


#does windspeed have an impact on Severity

accidents_tibble %>%
  ggplot(aes(x=as.factor(Severity),y=mean(`Wind_Speed(mph)`)))+geom_bar(stat="identity")+labs(title="Severity vs Windspeed", x="Severity", y="Wind Speed (mph)")


#what is the  visibility for accidents In Florida

fivestates %>%
  filter(State=="FL") %>%
  ggplot(aes(x=Severity,y=`Visibility(mi)`,color=Severity))+geom_point()



accidents_tibble$

#do traffic calming zones affect the severity

accidents_tibble$Severity[accidents_tibble$Severity==4 |accidents_tibble$Severity==3] <- "More Severe"
accidents_tibble$Severity[accidents_tibble$Severity==1 |accidents_tibble$Severity==2] <- "Less Severe"


accidents_tibble %>%
  filter(Severity=="More Severe") %>%
  ggplot(aes(x = 1, fill=Traffic_Calming)) +
  geom_bar() +
  coord_polar(theta="y")+
  labs(title="Traffic Calming Zone effect on more severe accidents")

accidents_tibble %>%
  filter(State=="GA"& Severity=="Less Severe") %>%
  ggplot(aes(x = 1, fill=Traffic_Calming)) +
  geom_bar() +
  coord_polar(theta="y")+
  labs(title="Traffic Calming Zone effect on less severe accidents")




#what portion of accidents happen at traffic  signals


accidents_tibble %>%
  filter(Severity=="More Severe") %>%
  ggplot(aes(x = 1, fill=Traffic_Signal)) +
  geom_bar() +
  coord_polar(theta="y")+
  labs(title="Prescence of traffic signal for more severe accidents")+
  scale_fill_manual(values = c("#FCF4A3","#4F517D")) 

accidents_tibble %>%
  filter(State=="GA"& Severity=="Less Severe") %>%
  ggplot(aes(x = 1, fill=Traffic_Signal)) +
  geom_bar() +
  coord_polar(theta="y")+
  labs(title="Prescence of Traffic signal for less severe accidents")+
scale_fill_manual(values = c("#FCF4A3","#4F517D"))

c4<-brewer.pal(n=8, name='Greens')
x<-display.brewer.pal(n = 3, name = 'Dark2')

#"#009F75"

accidents_tibble %>%
  group_by(Weather_Condition) %>%
  tally() %>%
  arrange(desc(n)) %>%
  top_n(8) %>%
  ggplot(aes(x=reorder(Weather_Condition, n), y=n, fill=c4))+geom_bar(stat="identity")+coord_flip()+
  labs(title="Weather conditions during Accidents", x="Weather Condition", y="Number of Accidents")+
  theme(legend.position = "none")

accidents_tibble %>%
  group_by(Weather_Condition) %>%
  tally() %>%
  arrange(desc(n)) %>%
  top_n(8) %>%
  ggplot(aes(x=reorder(Weather_Condition, n), y=n, fill=c4))+geom_bar(stat="identity")+coord_flip()+
  labs(title="Weather conditions during Accidents", x="Weather Condition", y="Number of Accidents")+
  scale_fill_manual(values = c("#B2182B", "#D6604D", "#F4A582" ,"#FDDBC7", "#D1E5F0", "#92C5DE", "#4393C3" ,"#2166AC"))+
  theme(legend.position = "none")


c4<-brewer.pal(n=9, name='OrRd')
C5<-brewer.pal(n=9, name='Greens')

  accidents_tibble %>%
    group_by(City)  %>%
    tally() %>%
    arrange(desc(n)) %>%
    top_n(9) %>%
    ggplot(aes(x=reorder(City, n), y=n, fill=c4))+geom_bar(stat="identity")+coord_flip()+
    labs(title="Cities with the most accidents", x="Cities", y="Number of Accidents")+
    scale_fill_manual(values = c4)+
    theme(legend.position = "none")
  
  accidents_tibble %>%
    group_by(State)  %>%
    tally() %>%
    arrange(desc(n)) %>%
    top_n(9) %>%
    ggplot(aes(x=reorder(State, n), y=n, fill=c4))+geom_bar(stat="identity")+coord_flip()+
    labs(title="States with the most accidents", x="States", y="Number of Accidents")+
    scale_fill_manual(values = c4)+
    theme(legend.position = "none")
  
  
 
  # Extracting Year
  
 
accidents_tibble<-accidents_tibble %>%
  mutate(Year=year(accidents_tibble$End_Time))
    
accidents_tibble %>%
  group_by(Severity)
