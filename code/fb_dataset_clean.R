fb_train <- read.csv("fb_train.csv", header = T)
fb_test <- read.csv("fb_test.csv", header = T)
fb.data <- read.csv("fb_data.csv", header = T)

#name
names(fb_train)[16] <- c("post_weekday")
names(fb_test)[16] <- c("post_weekday")
names(fb_test)[17] <- c("datetime_weekday")
names(fb_train)[17] <- c("datetime_weekday")
names(fb_train)[2] <- names("Page_likes")
names(fb_test)[2] <- c("Page_likes")
#merge
fb_data <- fb_train %>% full_join(fb_test)

#data clean
fb_data_clean <- fb_data %>% filter(total_time > 23 ) %>% mutate(y_comments = no_of_comments_first_24)
dim(fb_data_clean)

f1 <- read.csv("Features_Variant_1.csv", header = F)
f2 <- read.csv("Features_Variant_2.csv", header = F)
f3 <- read.csv("Features_Variant_3.csv", header = F)
f4 <- read.csv("Features_Variant_4.csv", header = F)
f5 <- read.csv("Features_Variant_5.csv", header = F)
t1 <- read.csv("Test_Case_1.csv" , header = F)
t2 <- read.csv("Test_Case_2.csv" , header = F)
t3 <- read.csv("Test_Case_3.csv" , header = F)
t4 <- read.csv("Test_Case_4.csv" , header = F)
t5 <- read.csv("Test_Case_5.csv" , header = F)
t6 <- read.csv("Test_Case_6.csv" , header = F)
t7 <- read.csv("Test_Case_7.csv" , header = F)
t8 <- read.csv("Test_Case_8.csv" , header = F)
t9 <- read.csv("Test_Case_9.csv" , header = F)
t10 <- read.csv("Test_Case_10.csv" , header = F)
ft <- read.csv("Features_TestSet.csv" , header =F)

fb_data <- f1 %>% full_join(f2)%>% full_join(f3)%>% full_join(f4)%>% full_join(f5)%>% full_join(t1)%>% full_join(t2)%>% full_join(t3)%>% full_join(t4)%>% full_join(t5)%>% full_join(t6)%>% full_join(t7)%>% full_join(t8)%>% full_join(t9)%>% full_join(t10)
fb_data <- fb_data%>%full_join(ft)

names(fb_data)[1:4] <- c("Page_likes","Page_Checkins","Page_talking_about","Page_Category")
names(fb_data)[5:29] <- c(paste("V" ,c(1:25),sep = ""))
names(fb_data)[30:39] <- c("total_comments" , "no_of_comments_24_base","no_of_comments_48_24", "no_of_comments_first_24", "V34",    
"total_time" , "Post_length" ,"Post.Share.Count","Promotion","H.Local")
names(fb_data)[40:46] <- c("sun","mon","tue","wed","thu","fri","sat")
names(fb_data)[54] <- c("Target Variable ")


fb_data <- fb_data[,-47:-53]
fb_data <- fb_data[,-30:-32]
fb_data <- fb_data[,-31]
fb_data <- fb_data[,-43]
fb_data <- fb_data[,-34]

###category selected
select<-which(fb_data$Page_Category=="2"|fb_data$Page_Category=="4"|fb_data$Page_Category=="8"|fb_data$Page_Category=="9"|fb_data$Page_Category=="18"|fb_data$Page_Category=="24"|fb_data$Page_Category=="25"|fb_data$Page_Category=="28"|fb_data$Page_Category=="31"|fb_data$Page_Category=="36"|fb_data$Page_Category=="37"|fb_data$Page_Category=="46"|fb_data$Page_Category=="66"|fb_data$Page_Category=="104")
data<-fb_data[select,]
data$Page_Category<-as.factor(data$Page_Category)
levels(data$Page_Category)
table(data$Page_Category)
barplot(table(data$Page_Category),col = "rosybrown2")
qqnorm(data$y_comments)#normal dist. or not
qqline(data$y_comments)

##comment categorized
quantile(data$y_comments,c(0.2,0.4,0.6,0.8))
for (i in 1:nrow(data)){
  if (data$y_comments[i]<=6){
    data$y_comments[i]<-1
  }else if(data$y_comments[i]>6 & data$y_comments[i]<=17){
    data$y_comments[i]<-2
  }else if(data$y_comments[i]>17 & data$y_comments[i]<=39){
    data$y_comments[i]<-3
  }else if(data$y_comments[i]>39 & data$y_comments[i]<=106){
    data$y_comments[i]<-4
  }else{
    data$y_comments[i]<-5
  }
}
write.csv(data,file="data.csv",row.names = F)
