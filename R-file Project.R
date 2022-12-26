

#We specify the directory we are working with and load the packages we need.

setwd("F:/Final Project - ITC 255")
getwd()

install.packages('ggplot2')
install.packages('plotly')
library(ggplot2)
library(plotly)
###############################################################################################
#First of all, we make create all the data that is required.
#Hourly wage: H 

H = rnorm(10000, 11, 3)

W = round(as.data.frame(H),0)

View(W)


write.csv(W, file = "F:/Final Project - ITC 255/FinalProject.csv")

#Then, we create the variable "X1" in order to complete the second step of our dataset after Y. 

p <- 0.4

#We generate 10000 random values of "Yes" and "No"

X1 <- sample(c("Yes", "No"), size=10000, replace=TRUE, prob=c(p, 1-p))

y=as.data.frame(X1)
View(y)
write.csv(y, file = "F:/Final Project - ITC 255/FinalProject2.csv")

#X2: Years of Experience 

X2 = rnorm(10000, 5, 2)

Xp = round(as.data.frame(X2), 0)

View(Xp)

z = as.data.frame(Xp)
write.csv(z, file = "F:/Final Project - ITC 255/FinalProject3.csv")

##########################################################################################

#Graphs for numerical variables to check their distribution

#Graph for Y:
plot(density(H), main = "HOURLY WAGE [Y]", xlab = "AMOUNT IN $", ylab = "DISTRIBUTION")
abline(h=0)
abline(v=mean(H), col = 'blue')
abline(v=sd(H), col="red")
legend('topright', legend = c("Mean = 11", "SD = 3"), fill = c("Blue", "red"))

#Graph for X2: 
plot(density(X2), main = "YEARS OF EXPERIENCE [X2]", xlab = "YEARS", ylab = "DENSITY")
abline(h=0)
abline(v=mean(X2), col = 'blue')
abline(v=sd(X2), col="red")
legend('topright', legend = c("Mean = 5", "SD = 2"), fill = c("Blue", "red"))

############################################################################################

#Confirming the X1 Binomial variable for input. 

l= table(X1)
View(l)
############################################################################################

#For the graphical analysis of the variables one by one, we first need to load the dataset we created using them. 

Dataset = read.csv("F:/Final Project - ITC 255/FinalProject.csv")
View(Dataset)

#Now, we name the variables' columns in order to make work easier. 

#Y = N1, X2 = N2, X1 = B

N1 = Dataset$Y..Hourly.Wage.
N2 = Dataset$X2..Years.of.Experience.
B = (Dataset$X1..Master.Degree.Holder.)
fdtb =as.data.frame(table(B))
View(fdtb)
############################################################################################

#Graphical analysis: 

#1) Y or N1 

g1a = ggplot(data = Dataset, aes(x=N1, fill = N1)) + 
  geom_histogram(fill = "purple") +
  theme(panel.background = element_blank())+
  xlab("HOURLY WAGE")+
  ylab('COUNT')+
  ylim(c(0,1500))
g1a2=plotly::ggplotly(g1a)
htmlwidgets::saveWidget(g1a2, file = 'g1.html')
g1a2

############################################################################################

#2) X1 OR B
View(Dataset)

years_xp=c()
for (k in 1:length(Dataset$X2)) {
  if(Dataset$X2[k]<3){
    years_xp[k]="INTERNS"
  } else if (Dataset$X2[k] >=3 & Dataset$X2[k]<=7) {
    years_xp[k]="REGULAR EMPLOYEES"
  } else {
    years_xp[k]="OLD EMPLOYEES"
  }
}
DTF=as.data.frame(cbind(Dataset$X2,years_xp))
View(DTF)

#Now, we create its FDT
fdt=function(x){
  absFreq=table(x)
  relFreq=prop.table(absFreq)
  cumFreq=cumsum(relFreq)
  fdtx=cbind(absFreq, relFreq, cumFreq)
  return(fdtx)
}
fdtDTF=as.data.frame(fdt(DTF$years_xp))
View(fdtDTF)
E=c("OLD EMPLOYEES","INTERNS","REGULAR EMPLOYEES")

#Now, we plot the graph.
g3a = ggplot(data = fdtDTF, aes(x = fdtDTF$absFreq, y = E, fill = E, alpha = 0.5)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values=c('GREEN', 'BLUE', 'RED'))+
  labs(x = "Frequency", y = "") +
  theme(panel.background = element_blank(),
        legend.position = "none")
g3b=plotly::ggplotly(g3a)
htmlwidgets::saveWidget(g3b, 
                        file = 'g3.html')

#######################################################################################

#Multiregression 

#First, we recall that Y =N1, X1 = B, and X2 = N2
reg_analysis = lm(N1~B+N2, data = Dataset)
summary(reg_analysis)

test1 = 11.079198 -0.013548 * 1 -0.005001*5
test1

11.079198 -0.013548 * 0 -0.005001*2
