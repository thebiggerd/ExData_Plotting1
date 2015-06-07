#The sqldf library allows for running a sql command against a file to filter by date
library(sqldf)
FileName <- "c:/temp/household_power_consumption.txt"
#only select the 2 dates we care about
FilteredDataQuery<-"SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
#Load data
mydata <- read.csv.sql(FileName, sql=FilteredDataQuery, sep=";")
#create and format a date and time 
mydata$DateAndTime <- as.POSIXct(strptime(paste(mydata$Date,mydata$Time), "%d/%m/%Y %H:%M:%S"))
#plot the data
plot(mydata$DateAndTime, mydata$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(mydata$DateAndTime, mydata$Sub_metering_2, col="red")
lines(mydata$DateAndTime, mydata$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)
#Create png
dev.copy(png, file = "c:/temp/plot3.png", height = 480, width = 480)
dev.off()