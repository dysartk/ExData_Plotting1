##Plot 4
##Load needed packages
library(RCurl)
library(data.table)
library(dplyr)
library(tidyr)
library(lubridate)
## Set working directory
setwd("~/Documents/Magic Briefcase/R Working Directory/Exploratory Data Analysis/Week 1/Plot_4")
## Read data table from UCI website
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url, destfile='epc.zip', method='curl')
## Unzip file to working directory
unzip("epc.zip")
## Read file into R and then make Date a date type and create POSIXlt Variable.
epc <- fread("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?"))
epc <- as.data.frame(epc)
epc_2 <- tbl_df(epc)
epc_2$Date <- as.Date(epc_2$Date, format = "%d/%m/%Y")
epc_2$timetemp <- paste(epc_2$Date, epc_2$Time)
epc_2$Time_2 <- strptime(epc_2$timetemp, format = "%Y-%m-%d %H:%M:%S")
## Define the Dates of Interest
Date_1 <- as.Date("2007-02-01")
Date_2 <- as.Date("2007-02-02")
## Subset data based on dates
epc_3 <- subset(epc_2, epc_2$Date > "2007-01-31" & epc_2$Date < "2007-02-03")
## Make Plot #3
x <- epc_3$Time_2
y <- epc_3$Global_active_power
a <- epc_3$Sub_metering_1
b <- epc_3$Sub_metering_2
c <- epc_3$Sub_metering_3
v <- epc_3$Voltage
grp <- epc_3$Global_reactive_power
png(file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
## Plot 1
plot(x,y, type = "l", ylab = "Global Active Power", xlab = " ")
## Plot 2
plot(x,v, type = "l", ylab = "Voltage", xlab = "datetime")
## Plot 3
plot(x,a, type = "l", xlab = " ", ylab = "Energy sub metering")
points(x,b, type = "l", col = "blue")
points(x,c, type = "l", col = "red")
legend("topright", bty = "n", cex = .75, lty = c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Plot 4
plot(x,grp, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()