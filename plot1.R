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

# Subset Data and plot
# png 1
Global_active_power <-as.numeric(dataset1$Global_active_power)
png("plot1.png")
hist(Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",
     main = "Global Active Power")
dev.off()