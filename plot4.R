## Project for Graphs
library(dplyr)

# Download and upzip the dataset file
filename <- "Electric Power Consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- "exdata_data_household_power_consumption"

if(!file.exists(filename)) {
  download.file(url,filename,mode="wb")
}

unzip("Electric Power Consumption.zip",files=NULL, exdir=".")

# Read datasets when Date = "2007-02-01" and "2007-02-02"
date_select <-c("1/2/2007","2/2/2007")
dataset <- read.table("household_power_consumption.txt",header=TRUE, stringsAsFactors = FALSE, sep = ";")
dataset1 <-tbl_df(dataset[dataset$Date %in% date_select,]) 

# Replace all "?" for NA
dataset1[dataset1=="?"] <- NA

# Convert the date format
dataset1$Date_time <- strptime(paste(dataset1$Date, dataset1$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# png 4, 4 plots  
# Global Reactive Power ~ Time
png("plot4.png")
par(mfrow=c(2,2))
# 1 Global Active Power ~ Time
plot(dataset1$Date_time,as.numeric(dataset1$Global_active_power),type="l",
     ylab = "Global Active Power (kilowatts)",xlab = "")
# 2 Voltage ~ Time 
plot(dataset1$Date_time,as.numeric(dataset1$Voltage),type="l",
     ylab = "Voltage",xlab = "datetime")

# 3 Energy Sub Metering~Time with 3 legends
plot(dataset1$Date_time,as.numeric(dataset1$Sub_metering_1),type = "l",xlab = "",
                    ylab = "Energy Sub Metering")
lines(dataset1$Date_time,as.numeric(dataset1$Sub_metering_2),type = "l",col="red")
lines(dataset1$Date_time,as.numeric(dataset1$Sub_metering_3),type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),
       lwd = 2)

# 4 Global Reactive Power ~ Time
plot(dataset1$Date_time,as.numeric(dataset1$Global_reactive_power),type="l",
     ylab = "Global_reactive_Power",xlab = "datetime")
dev.off()