library(Boruta)
train <- read.csv("fb_data.csv",header = TRUE)
summary(train)

boruta.train <- Boruta(y_comments~., data=train, ntree=100, doTrace=2, maxRuns = 15, pValue = 0.01)
print(boruta.train)
plot(boruta.train)

#TentativeRoughFix(boruta.train)