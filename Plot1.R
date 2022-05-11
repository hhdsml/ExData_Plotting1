#==================================================
#    Project 1 exploratory data analysis course
#    Plot1
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

# change columns to numeric

sub_data[,c(3:9):= lapply(.SD, as.numeric), .SDcols = c(3:9)]

# open png file
png("plot1.png", width = 480, height = 480)

# make plot1 

hist(sub_data$Global_active_power, main = "Global active power", xlab = "Global active power (killowatts)",
     ylab = "Frequency", col = "red")

# close device file
dev.off()
