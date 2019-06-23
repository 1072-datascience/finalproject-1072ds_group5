# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("USAGE: Rscript model_rf.R --data data.csv", call.=FALSE)
}

# parse parameters
i<-1 
while(i < length(args))
{
  if(args[i] == "--data"){
    data_in<-args[i+1]
    i<-i+1
  }else{
    stop(paste("Unknown flag", args[i]), call.=FALSE)
  }
  i<-i+1
}

library(caret)
library(randomForest)
#read files
data <- read.csv(data_in,header = T,sep = ",")
print("read files:finished")

#data preprocessing
data <- data[,-c(2,3,5,15,20,30,34)]
finaldata <- data[data$Page_Category==2,]
for(i in c(4,8,9,18,24,25,28,31,36,37,46,66)){
  finaldata <- rbind(finaldata,data[data$Page_Category==i,])
}
print("data preprocessing:finished")

#split test data
trainIndex <- createDataPartition(finaldata$y_comments,p = 0.8,list = F)
trainData <- finaldata[trainIndex,]
testData <- finaldata[-trainIndex,]
print("split test data:finished")

#build model
model_rf <- randomForest(factor(y_comments)~.,data = trainData,ntree=100,nodesize=3,mtry = 31)
print("build model:finished")

#predict test data
pre_rf <- predict(model_rf,testData)
print(matrix <- table(real=testData$y_comments,predict=pre_rf))
print(auc_rf <- sum(diag(matrix))/sum(matrix))