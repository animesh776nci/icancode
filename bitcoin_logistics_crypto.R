#Libraries
library(dplyr)
library(ggplot2)

#Read CSV data.

crypto_data =read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/crypto-markets.csv",header = T)


#Data manipulation

#Filtered data for 7 prime crypto currency:

df.crypto<- crypto_data %>% filter(name %in% c('Bitcoin','Bitcoin Cash','Ethereum','Tether','Litecoin','XRP','Stellar'))%>% select(c('open','low','high','close'))
                                                                                                                                   
str(df.crypto)
summary(df.crypto)

#Adding a new column with mean value of high and low market price.

df.crypto$mean<- ((df.crypto[,2]+df.crypto[,3])/2)
View(df.crypto)

#Adding a new column with binary value of i.e (0,1) for low and and high close price respectively


df.crypto$status <- 1 #converted all rows to high first  

for (i in (1:nrow(df.crypto+1))){
  if (df.crypto$close[i] < df.crypto$mean[i]){ #converting low close price to 0
      df.crypto$status[i] <- 0
  }
}

#Removing mean column as not necessary for our model
df.crypto$mean <- NULL

#Exploratory data analysis

#Cleaning data

sum(is.na(df.crypto)) #check for na value 

sum(df.crypto$mean == 0) #No value is 0

boxplot(df.crypto)

df.crypto$status <- as.factor(df.crypto$status) 

#assumption : looking at boxplot the outliers are consistent,so we need to ignore outliers.

#plotting status histogram

ggplot(df.crypto,aes(status)) + geom_bar(aes(fill=factor(status)),alpha=0.5) #status classification %

#splitting test and train data
set.seed(123)

indx.s <- sample(2,nrow(df.crypto),prob = c(0.8,0.2),replace = T)

cr.train <- subset(df.crypto,indx.s==1,)
cr.test <- subset(df.crypto,indx.s==2,)

head(cr.train)
head(cr.test)

#Model
str(df.crypto)

log.cr.model <- glm(formula=status ~ . , family = binomial(link='logit'),data = cr.train,control = list(maxit = 100))

summary(log.cr.model)

#low,high,close are the most significant values.


fitted.test.model <- predict(log.cr.model,newdata=cr.test,type='response')



model.results <- ifelse(fitted.test.model > 0.5,1,0)
misClass.Error <- mean(model.results != cr.test$status)
print(paste('Accuracy',1-misClass.Error))   #57.07 accuracy

#Evaluation

table(cr.test$status, fitted.test.model)

plot(table(cr.test$status, fitted.test.model)) #confusion matrix







