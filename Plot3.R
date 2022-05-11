#==================================================
#    Project 1 exploratory data analysis course
#    Plot4
#    author : hh
#    time : 5/2022
#==================================================

# remove environment

rm(list = ls())

# load package

library("data.table")

# download data

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "./Exploratory data analysis/datafile.zip")
unzip(zipfile = "./Exploratory data analysis/datafile.zip")

# get data

powerdata <- fread("./household_power_consumption.txt", na.strings="?")


# Change Date Column to Date Type
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

# data from 2007-02-01 to 2007-02-02

sub_data <-powerdata[(Date >= as.Date("2007-02-01")) & (Date <= as.Date("2007-02-02"))]

# new column datetime

sub_data[, datetime := paste(as.character(Date),Time)]
sub_data[, datetime:= strptime(datetime,format = "%Y-%m-%d %H:%M:%S")]

# change columns to numeric

sub_data[,c(3:9):= lapply(.SD, as.numeric), .SDcols = c(3:9)]

# set langue system

Sys.setlocale("LC_TIME", "English")

# open png file
png("plot3.png", width = 480, height = 480)

plot(x = sub_data$datetime, y = sub_data$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = sub_data$datetime, y = sub_data$Sub_metering_2,col="red")
lines(x = sub_data$datetime, y = sub_data$Sub_metering_3,col="blue")
legend("topright",lty = 1
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))

dev.off()

