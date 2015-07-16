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
if (getwd()=='C:/Users/calin/Documents') setwd('D:/data_R/exdata-030/Course Project 2/ExData_Plotting2/')

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

# Answer: in the graph below

# prepare data
totalEmissions = aggregate(Emissions~year, NEI, FUN=sum)

totalEmissions$Emissions = round(totalEmissions$Emissions/1000^2,2)

#Open device
png(filename="plot1.png", width = 600, height = 600)

# plot data
plot(totalEmissions, 
     type="p", col="red", xlab="Year (1999 - 2008)",ylim=c(0,8),
     ylab="PM2.5 Emmisions in Millions of Tons")
lines(totalEmissions, pch=22, lwd=10, col="red")
title(main="Emissions of PM2.5 in the United States have decreased around 50%")
text(totalEmissions, labels=round(totalEmissions$Emissions,1), cex= 1, pos=3)

# closing device
dev.off()