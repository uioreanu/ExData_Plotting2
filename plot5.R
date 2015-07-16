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

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# prepare data
# find the SCCs that are related to Coal
SCC_Vehicle = SCC[grepl("vehicle", SCC$Short.Name, ignore.case=TRUE),]
dim(SCC_Vehicle)
# [1] 260  15
length(unique(SCC_Vehicle$SCC))
# 260
NEI_Vehicle = subset(NEI, SCC %in% SCC_Vehicle$SCC)
NEI_VehicleBaltimore = subset(NEI_Vehicle, fips == "24510")
totalEmissionsVehBalt = aggregate(Emissions~year, NEI_VehicleBaltimore, FUN=sum)

# Open device
png(filename="plot5.png", width = 500, height = 500)

# barplot data 
barplot(totalEmissionsVehBalt$Emissions, 
        names.arg=totalEmissionsVehBalt$year,
        xlab="Year (1999 - 2008)",
        ylab="PM2.5 Emmisions in Tons",
        main="Decreased Emissions from vehicles in Baltimore City, ML")

# closing device
dev.off()