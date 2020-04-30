#Libraries
library(ISLR)
library(dplyr)
library(class)
library(gmodels)
library(caret)
library(e1071)

readmitted_data =read.csv("D:/nci_msc/Data Mining and Machine learning/Dataset/diabetic_data.csv",header = T)
str(readmitted_data)

colnames(readmitted_data)

#Exploratory Data analysis
colnames(readmitted_data)
str(readmitted_data)
summary(readmitted_data)

#Dropping unwanted data
readmt <- select(readmitted_data,c(time_in_hospital,readmitted,num_lab_procedures,num_procedures,num_medications,number_diagnoses))

str(readmt)
summary(readmt)
View(readmt)

#Changing into character to categorise the value
readmt$readmitted <- as.character(readmt$readmitted)


#Categorising readmitted value <30> = 1, No = 0

readmt$readmitted[readmt$readmitted == 'NO'] <- '0'
readmt$readmitted[readmt$readmitted != '0'] <- '1'

#Changing back to factor for prediction model 
readmt$readmitted <- as.factor(readmt$readmitted)

#response variable:
table(readmt$readmitted)

readmt$readmitted <- factor(readmt$readmitted, levels = c("0","1"),labels = c("No", "Yes")) 
prop.table( table(readmt$readmitted) )

View(readmt_df)
summary(readmt)


normalize <- function(x){
  return( (x - min(x))/(max(x) - min(x)) )
}
readmt_df <- as.data.frame(lapply(readmt[-2], normalize)) 
summary(readmt_df)

#train and test dataset with predictor variable:

idx <- sample(2,nrow(readmt_df),prob= c(0.8,0.2),replace = T) 

readmt_df_train <- subset(readmt_df,idx ==1)
readmt_df_test <- subset(readmt_df,idx ==2)

nrow(readmt_df_train)

#test and train lable with response column
readmt_tr_label <- subset(readmt$readmitted,idx==1)
readmt_tst_label <- subset(readmt$readmitted,idx==2)

#Model
readmt_pred <- knn(train = readmt_df_train, test = readmt_df_test, cl = readmt_tr_label, k=285)

#Evaluation:

CrossTable(x = readmt_tst_label, y = readmt_pred, prop.chisq=FALSE)

readmt_pred

plot(fit)


