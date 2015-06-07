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
hist(mydata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
#Create png
dev.copy(png, file = "c:/temp/plot1.png", height = 480, width = 480)
dev.off()