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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions? plot6.png

# libs
library(ggplot2)

# prepare data
# find the SCCs that are related to Coal
SCC_Vehicle = SCC[grepl("vehicle", SCC$Short.Name, ignore.case=TRUE),]
dim(SCC_Vehicle)
# [1] 260  15
length(unique(SCC_Vehicle$SCC))
# 260
NEI_Vehicle = subset(NEI, SCC %in% SCC_Vehicle$SCC)
NEI_VehicleBaltimore = subset(NEI_Vehicle, fips == "24510")
NEI_VehicleBaltimore$city <- "Baltimore City, Maryland"
NEI_VehicleLA = subset(NEI_Vehicle, fips == "06037")
NEI_VehicleLA$city <- "Los Angeles County"
NEICombined <- rbind(NEI_VehicleBaltimore,NEI_VehicleLA)

# Open device
png(filename="plot6.png", width = 600, height = 500)

#ggplot 
ggplot(NEICombined, aes(x=factor(year), y=Emissions)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y="Total PM2.5 Emission") + 
  labs(title="Los Angeles vs Maryland changes over time in PM2.5 Vehicle Emissions")

# closing device
dev.off()