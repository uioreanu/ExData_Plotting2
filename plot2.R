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

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# prepare data
NeiBaltimore = subset(NEI, fips == "24510")
totalEmissionsBaltimore = aggregate(Emissions~year, NeiBaltimore, FUN=sum)

# Open device
png(filename="plot2.png", width = 600, height = 600)

# barplot data 
barplot(totalEmissionsBaltimore$Emissions, 
    names.arg=totalEmissionsBaltimore$year,
     xlab="Year (1999 - 2008)",
     ylab="PM2.5 Emmisions in Tons",
     main="Decreasing Emissions in Baltimore City, ML (Tons)")

# closing device
dev.off()