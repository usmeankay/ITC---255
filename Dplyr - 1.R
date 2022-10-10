#Data manipulation with Dplyr package. 

library("dplyr")
install.packages("dplyr")
install.packages("wooldridge")
#Since we did not have the package at first, we simply installed it. 

#Checking again. 

library("dplyr")
library("wooldridge")
View(airfare)
str(airfare)
head(airfare)
#The data set has merely numerical/integer values. 

#In this assignment, I will just focus on the quantitative analysis, and try to practice my way through.

#1) FILTER using different logical operators. (Can't use on qualitative ones since the data does not contain such values.)

#Filtering makes sub-data sets, as it filters the already existing data we have into something we require from the data set. 

fYear = filter(airfare, year < 2000, fare > 100)

#By running the filter above, we will only get the observations from the data set that have traveled before the year 2000 and have paid more than 100$ for the air trip.
View(fYear)

#Using logical operators (&, |, !)

#First of all, we use AND or &. 
#If we want to find out flights that had more than less than 50 people in them and the fare was higher than 100, we can use the following operator. 

filter1 = filter(airfare, passen < 50 & fare > 100)
View(filter1)

#Which shows us that there were 27 flights in total during the given years of the data set that had passengers less than 50 and fares higher than 100.

#Secondly, we use OR or |. 
#Lets be a little more specific. Now lets see flights that were after the year 1999 or 2000, OR had more than 2000 passengers and had a fare greater than 200. 

filter2 = filter(airfare, year > 1999 & 2000 | passen>2000, fare > 200)
View(filter2)

#The observations in the results show the airfares that meet the conditions we put forth. 

#Lets use the NOT logic operator now. 

filter3 = filter(airfare, year !=2000)
View(filter3)

#The code above will show flights from any years other than the year 2000. 

#Above are sub-datasets that show specific conditions given to them through the filter function.




#Using the %in% function. 

filter4 = filter(airfare, fare %in% c(300, 500))
View(filter4)

#As we can see, it gives us people that have paid a fare between 300 to 500, and we have only 5 observations regarding those conditions. 

#Since I have no non-numerical variable, I will use another example just to demonstrate and practice. 

filter5 = filter(airfare, passen %in% c(600,1000))
View(filter5)

#We can tell from the above code that there are only three flights in the years 1998, 1999, and 2000 that had passengers from a range of 600-1000 in the dataset. 

#Similarly, we can use the logical operators here as well. 

#For example, in order to find the people from flights before 1998, we use: 

filter6 = filter(airfare, year < 1998)
View(filter6)

#Which shows us exactly 1149 flights before 1998, mostly from the year 1997. 

#We can also change literally the logical operator of the above code only to find flights from 1998 when we use equal, and after that year if we use the greater sign. 



#2) ARRANGE. 

names(airfare)
DescendingFares = head(arrange(airfare, desc(fare)))
View(DescendingFares)

#This function just arranges the dataset's highest fares in this case and goes down to in a descending order. 

#3) SELECT. 

#This function could be used to select different columns from the data set in order to create 

names(airfare)
select(airfare, c(year, fare, passen))
#Similarly, if we want the fare on the left most side we can use "everything" in it. 

select(airfare, fare, everything())

#The column function is used to include certain columns, for example if we want to select the first three columns we can write. 
select(airfare, year:dist)

#If we want to exclude certain columns, we can do that as well. 
select(airfare, -(dist:lpassen))

#I excluded all the columns from distance to the last one here. 


#4) RENAME. 

#This function is used to rename a certain column, as obvious from the name. For example. 

airfare1 = rename(airfare, distance=dist)
head(airfare1)

#and it becomes distance instead of dist. 


#5) MUTATE. 
#This function adds a new column while making a mathematical calculation for better understanding and interpretation of our data. 

#For example, if we consider the distance to be in kilometers and the fare in dollars, dividing the fare by distance would give us the unit dollar per kilometer price of the trip. 
#Unit price per kilometer = fare/distance 
UnitCost = head(mutate(airfare1, unit_cost_per_kilometer=fare/distance))

View(UnitCost)
 
#6) SUMMARIZE. (This function can summarize the data through different things, as in standard deviation, mean, median and so on)

summarize(airfare1, median(fare), median(passen))

#The function tells us that the median of the fare column is 168, and 357 for the passenger column respectively. 

sum1= group_by(airfare1, year)
summarize(sum1, mean(fare), sd(fare))

#The group by function gives us the mean and standard deviation of ordered years in the scenario I have used it in. We can see that the fares have increased gradually in the first three years, but in 2000 they increased by a big difference, which suggests some association. 

#7) PULL. (extracts a variable out of the dataset and presents it as a vector)
pull1 = pull(airfare1, year)
pull1

#8) SAMPLE_N 

#This function draws a random sample of a specific size from our dataset. 

dim(airfare1)
#This gives us the information about how many variables and observations we have in the dataset, in my case there are 4596 obs. and 14 variables/columns.
#Now we can select a random sample from this dataset by using the following function: 

sampled1=sample_n(airfare1, 100)
head(sampled1)
View(sampled1)

#We have a total of 100 randomly selected statistic or as we would call it sample statistic from the population data set of airfare. 