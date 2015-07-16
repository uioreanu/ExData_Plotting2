#   
#   Coursera Online University
#   Exploratory Data Analysis
#   July 2015 session
#
#   Course Project 2
#   exploring the Fine particulate matter (PM2.5) data
#   Calin Uioreanu
# 

# cleanup
rm(list=ls())
gc()
setwd('D:/data_R/exdata-030/Course Project 2/')

# check with dir() to see if the right downloaded files are present
if (sum(c("summarySCC_PM25.rds", "Source_Classification_Code.rds") %in% dir())<2) {
  print("Please download the Data for Peer Assessment [29Mb] from Coursera and unzip it in the working dir")
  stop()
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#print(object.size(NEI), units="Mb")
#648.7 Mb

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# prepare data
totalEmissions = aggregate(Emissions~year, NEI, FUN=sum)

#Open device
png(filename="plot1.png", width = 480, height = 480)

# plot it
plot(totalEmissions, 
     type="p", col="red", xlab="Year",
     ylab="PM2.5 Emmisions between 1999 - 2008")
lines(totalEmissions, pch=22, lwd=5, col="red")
title(main="Total PM2.5 emission from all sources")

# closing device
dev.off()