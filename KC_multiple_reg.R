#libraries
library(dplyr)
library(ggplot2)
library(ggthemes)
library(caTools)

#Data loading in csv

h_data = read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/kc_house_data.csv",header = T)
View(h_data)
dim(h_data)
str(h_data)
summary(h_data)

#Selecting column required for analysis

df_house <- (select(h_data,c(price,bedrooms,sqft_living,waterfront,yr_built,floors,waterfront,condition,grade,bathrooms)))

str(df_house)
View(df_house)
summary(df_house)


#Correleation

#All columns are numeric already, so no need to convert.

cor(df_house)

#corplot library

install.packages("corrgram")
library(corrgram)
library(corrplot)

#Plot
corrplot(cor(df_house),method='color')

corrgram(cor(df_house),order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

#Removing waterfront as it is least correlated

df_house$waterfront <- NULL

summary(df_house)


#Data_cleaning
sum(is.na(df_house))  #check for na values

sum(df_house$price == 0) #check for any zero value in respnse variable

boxplot(df_house) #check for outliers

summary(df_house$price) #checking quartile value
IQR_price = 645000 - 321950 
ul_price = 645000+1.5*IQR_price #setting upper limit

summary(df_house$bedrooms) # only outlier is 33 rooms


#summary(df_house$sqft_living)
#IQR_sqft = 2550 - 1427   #inter quantile range
#ul_sqft = 2550+1.5*fqt_sqft

df_house_clean = subset(df_house,price<=ul_price & bedrooms <= 11)
summary(df_house_clean)

normalize <- function(x){
  return( (x - min(x))/(max(x) - min(x)) )
}
df_house_norm <- as.data.frame(lapply(df_house_clean, normalize)) 

boxplot(df_house_norm)


#Spliting test and train data

set.seed(121)

indx <- sample(2,nrow(df_house_norm),prob = c(0.8,0.2),replace = T) 

h_train <- subset(df_house_clean,indx == 1,) 
h_test <- subset(df_house_clean,indx == 2,)

View(h_train)
nrow(h_train)

str(h_test)

#Model

h_model <- lm(price ~. , h_train)
summary(h_model)
h_model

#Residual : Residual = Observed value - Predicted value

h_res <- residuals(h_model)
h_res <- as.data.frame(h_res)  #converting into data frame for plotting

head(h_res)

ggplot(h_res,aes(h_res))+geom_histogram(fill='green',alpha=0.5)

#model plot

plot(h_model)
summary(model)

# Prediction

price_pred <- predict(h_model,h_test)
price_pred <- round(price_pred)
comp_pred_price <- cbind(price_pred,h_test)
colnames(comp_pred_price) <- c('predicted','real')
comp_pred_price <- as.data.frame(comp_pred_price)
View(comp_pred_price$pred)

#handling 0 values

change_Negtozero <- function(x){
  if  (x < 0){
    return(0)
  }else{
    return(x)
  }
}

comp_pred_price$pred <- sapply(comp_pred_price$pred,change_Negtozero)

#Evaluation

#mean square error
house_mse <- mean((comp_pred_price$real - comp_pred_price$pred)^2)
house_mse

#root mean square error

#house_mse^0.5

#R square value

R2_i <- sum((comp_pred_price$pred - comp_pred_price$real)^2)
R2_f <- sum((mean(df_house$price) - comp_pred_price$real)^2)


R2 <- 1-(R2_i/R2_f)
R2

#Adjusted R square

#R2adj <- 1- (((1-R2)*(N-1))/(N-P-1))

R2adj <- 1- (((1-R2)*(4175-1))/(4175-8-1))
R2adj

#Actual vs Predicted graph
ggplot(comp_pred_price, aes(predicted)) +
  geom_line(aes(y = comp_pred_price$real, colour = "actual")) +
  geom_line(aes(y = comp_pred_price$pred, colour = "predicted"))
