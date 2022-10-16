#Pie Chart Assignment. 

#First of all, we launch our dataset into R. 


library(dplyr)
library(wooldridge)

View(airfare)

#Since my dataset has all numerical variables, I need to create a categorical one (I will use three different classes for it). 

#The variable I will use is "Fare" for the flights, and the categories will be "high fare", "medium fare", and finally "low fare" flights.

catFare=c()

for (x in 1:length(airfare1$fare)) {
  if(airfare1$fare[x]<140){
    catFare[x]="lowFare"
  } else if (airfare1$fare[x]>=170 & airfare1$fare[x]<210) {
    catFare[x]="mediumFare"
  } else {
    catFare[x]="highFare"
  }
}


fareAmount = cbind(airfare1$fare, catFare)
View(fareAmount)

#We got the classes we wanted, which takes us to the next step of creating a Pie Chart for the Qualitative variable. 


install.packages("ggplot2")
library(ggplot2)

fdtCatFare= table(catFare)
fdtCatFare

fdtFare=as.data.frame(fdtCatFare)
fdtFare
colnames(fdtFare)=c("FareCategory","CategoryFrequency")
fdtFare
g0=ggplot(fdtFare, aes(x="", y=CategoryFrequency, fill=FareCategory))
gg=g0+geom_col()+
  coord_polar(theta = "y")+
  theme_classic()+
  theme(plot.title = element_text(colour = "black",
                                  size = 14, 
                                  face = "bold", 
                                  hjust = .5))+
  ggtitle('FREQUENCY OF HIGH/MEDIUM/LOW FLIGHT FARES')+
  geom_text(aes(label=FareCategory), 
            position = position_stack(vjust = .5))+
  scale_fill_manual(values = c(rainbow(3)))+
  theme(legend.position = 'bottom')
gg

ggsave('FareDist.png')
