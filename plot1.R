##Plot 1
##Load needed packages
library(RCurl)
library(data.table)
library(dplyr)
library(tidyr)
library(lubridate)
## Set working directory
setwd("~/Documents/Magic Briefcase/R Working Directory/Exploratory Data Analysis/Week 1/Plot_1")
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
## Make Plot #1
hist(epc_3$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()