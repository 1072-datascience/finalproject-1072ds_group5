library(Boruta)
train <- read.csv("fb_data.csv",header = TRUE)
summary(train)

boruta.train <- Boruta(y_comments~., data=train, ntree=100, doTrace=2, maxRuns = 200, pValue = 0.01)
print(boruta.train)
#plot(boruta.train)

plot(boruta.train, xlab="", xaxt="n")

lz<-lapply(1:ncol(boruta.train$ImpHistory),function(i)
  boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
names(lz)<-colnames(boruta.train$ImpHistory)
Labels<-sort(sapply(lz,median))
axis(side=1, las=2, labels = names(Labels),
     at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)


#TentativeRoughFix(boruta.train)