library(dplyr)
library(rpart)
library(rpart.plot)
library(ggplot2)

#Data loading from csv
readmitted_data =read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/diabetic_data.csv",header = T)
str(readmitted_data)

colnames(readmitted_data)

#Exploratory Data analysis

readmt <- select(readmitted_data,c(time_in_hospital,readmitted,num_lab_procedures,num_procedures,num_medications,number_diagnoses))
str(readmt)
summary(readmt)
View(readmt)

readmt$readmitted <- as.character(readmt$readmitted)


#Categoring readmitted value No = 0  and (<30>) to 1

readmt$readmitted[readmt$readmitted == 'NO'] <- '0'
readmt$readmitted[readmt$readmitted != '0'] <- '1'

readmt$readmitted <- as.factor(readmt$readmitted)

#plotting status histogram

ggplot(readmt,aes(readmitted)) + geom_bar(aes(fill=factor(readmitted)),alpha=0.5) #status classification %

#Model:

dtree_dia <- rpart(readmitted ~ . , method='class', data= readmt)


#Evaluation:

printcp(dtree_dia)

plotcp(dtree_dia)

prp(dtree_dia)

rpart.plot(dtree_dia, box.palette="RdBu", shadow.col="gray", nn=TRUE)

text(dtree_dia, use.n=TRUE, all=TRUE)
