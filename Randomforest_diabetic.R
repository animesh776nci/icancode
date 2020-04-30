#########REJECTED####################

install.packages("randomForest")
library('randomForest')
library(corrplot)
install.packages("rpart")
library('dplyr')
install.packages("party")
library(party)

#read csv
readmitted_data =read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/diabetic_data.csv",header = T)
colnames(readmitted_data)

#Exploratory Data analysis

str(readmitted_data)
summary(readmitted_data)

readmt <- select(readmitted_data,c(time_in_hospital,readmitted,num_lab_procedures,num_procedures,num_medications,number_diagnoses))
str(readmt)
summary(readmt)
View(readmt)

readmt$readmitted <- as.character(readmt$readmitted)


#Categoring readmitted value No = 0  and (<30>) to 1

readmt$readmitted[readmt$readmitted == 'NO'] <- '0'
readmt$readmitted[readmt$readmitted != '0'] <- '1'

readmt$readmitted <- as.factor(readmt$readmitted)

table(readmt$readmitted)

#Model

model <- randomForest(readmitted ~ .,   data=readmt)
cforest(readmitted ~ ., data=readmt, controls=cforest_control(mtry=2, mincriterion=0))

#Evaluation

model
importance(model)
