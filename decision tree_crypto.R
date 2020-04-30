library(dplyr)
library(ggplot2)
install.packages('rpart')
library(rpart)
install.packages('rpart.plot')
library(rpart.plot)

crypto_data =read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/crypto-markets.csv",header = T)


#Data manipulation

#Filtered data for 7 prime crypto currency:

df.crypto<- crypto_data %>% filter(name %in% c('Bitcoin','Bitcoin Cash','Ethereum','Tether','Litecoin','XRP','Stellar'))%>% select(c('open','low','high','close'))

str(df.crypto)
summary(df.crypto)

#Exploratory data analysis

#Adding a new column with mean value of high and low market price.

df.crypto$mean<- ((df.crypto[,2]+df.crypto[,3])/2)
View(df.crypto)

#Cleaning data

str(df.crypto)

df.crypto$status <- as.factor(df.crypto$status)

sum(is.na(df.crypto)) #check for na value 

sum(df.crypto$mean == 0) #No value is 0

#assumption : looking at boxplot the outliers are consistent,so we need to ignore outliers.
#Adding a new column with binary value of i.e (0,1) for low and and high close price respectively



df.crypto$status <- 1 #converted all rows to high first  

for (i in (1:nrow(df.crypto+1))){
  if (df.crypto$close[i] < df.crypto$mean[i]){ #converting low close price to 0
    df.crypto$status[i] <- 0
  }
}

df.crypto <- df.crypto[-5] #removing mean column

table(df.crypto$status)



#plotting status histogram

ggplot(df.crypto,aes(status)) + geom_bar(aes(fill=factor(status)),alpha=0.5) #status classification %

#Model:

dtree_crypto <- rpart(formula = status ~ . , method='class', data= df.crypto)

plotcp(dtree_crypto)

#to get the root node error
printcp(dtree_crypto)

#tree model
rpart.plot(dtree_crypto, box.palette="RdBu", shadow.col="gray", nn=TRUE)

prp(dtree_crypto)

text(dtree_crypto, use.n=TRUE, all=TRUE)
