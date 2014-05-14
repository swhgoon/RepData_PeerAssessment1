rm(list = ls())

activitydata <- read.csv("activity.csv", colClasses=c("integer", "Date", "integer"))
summary(activitydata)

steps_by_date <- aggregate(steps ~ date, activitydata, sum)
# hist(steps_by_date$steps,breaks=10, col="lightblue", xlab="Steps", labels=T,
#      main="Histogram of the total number of steps taken each day")

mean(steps_by_date$steps)
median(steps_by_date$steps)

steps_by_interval <- aggregate(steps ~ interval, activitydata, mean)
max_steps_by_interval <- steps_by_interval[which.max(steps_by_interval$steps),]
# plot(steps_by_interval, type="l",
#      xlab="Time series of the 5-minute interval",
#      ylab="The average number of steps taken",
#      main="The average daily activity pattern"
# )
i <- max_steps_by_interval$interval
# abline(v=i,col=2, lty=2)
# mtext(side=1,text=i, col=2, at=i,line=1)

print(sum(is.na(activitydata$steps)))

activitydata$steps