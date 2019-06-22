library(ggplot2)
options(scipen=999)
data <- read.csv("fb_data_total.csv")

summary(data$Page_likes)
ggplot(data = newdata, aes(x = Page_likes)) +geom_histogram(bins = 100)
gg <-  ggplot(data = data, aes(x = Page_likes)) +geom_histogram(bins = 100)+scale_y_log10()



summary(data$Page_Checkins)
ggplot(data = data, aes(x = Page_Checkins)) +geom_histogram(bins = 200)
ggplot(data = data, aes(x = Page_Checkins)) +geom_histogram(bins = 200)+scale_y_log10()



summary(data$Page_talking_about)
ggplot(data = data, aes(x = Page_talking_about)) +geom_histogram(bins = 200)
ggplot(data = data, aes(x = Page_talking_about)) +geom_histogram(bins = 200)+scale_y_log10()



summary(data$Page_Category)
ggplot(data = data, aes(x = Page_Category)) +geom_histogram(bins = 200)


days <- data.frame(sun=sum(data$sun),
                   mon=sum(data$mon),
                   tue=sum(data$tue),
                   wed=sum(data$wed),
                   thu=sum(data$thu),
                   fri=sum(data$fri),
                   sat=sum(data$sat))
barplot(as.matrix(days),beside=T,names.arg = names(days))



summary(data$Post_length)
ggplot(data = data, aes(x = Post_length)) +geom_histogram(bins = 200)
ggplot(data = data, aes(x = Post_length)) +geom_histogram(bins = 200)+scale_y_log10()



summary(data$Post.Share.Count)
ggplot(data = data, aes(x = Post.Share.Count)) +geom_histogram(bins = 200)
gplot(data = data, aes(x = Post.Share.Count)) +geom_histogram(bins = 200)+scale_y_log10()

