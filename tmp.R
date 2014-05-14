rm(list = ls())

activitydata <- read.csv("activity.csv", colClasses=c("integer", "Date", "integer"))
summary(activitydata)

steps_bydate <- aggregate(steps ~ date, activitydata, sum)
# hist(steps_bydate$steps,breaks=10, col="lightblue", xlab="Steps", labels=T,
#      main="Histogram of the total number of steps taken each day")

steps_byinterval <- aggregate(steps ~ interval, activitydata, mean)
# max_steps_byinterval <- steps_byinterval[which.max(steps_byinterval$steps),]
# plot(steps_byinterval, type="l",
#      xlab="Time series of the 5-minute interval",
#      ylab="The average number of steps taken",
#      main="The average daily activity pattern"
# )
# i <- max_steps_byinterval$interval
# abline(v=i,col=2, lty=2)
# mtext(side=1,text=i, col=2, at=i,line=1)

activity <- activitydata
activity$steps <- as.integer(lapply(1:nrow(activity), function(i){
  x <- activity$steps[i]
  if(is.na(x)) with(steps_byinterval, steps[interval == activity$interval[i]])
  else x
}))

Sys.setlocale("LC_TIME", "en_US.UTF-8")

activity$daytype <- as.factor(ifelse(weekdays(activity$date,abbreviate=T) %in% c("Sat", "Sun"), "weekend", "weekday"))

library(lattice)
with(activity,
     xyplot(steps ~ interval | daytype, 
            aggregate(steps ~ interval + daytype, activitydata, mean), 
            layout = c(1, 2), type = "l",
            xlab = "Interval", ylab = "Number of steps",
            main = "Activity patterns between weekdays and weekends"
     ))
