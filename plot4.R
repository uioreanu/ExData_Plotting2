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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# prepare data
# find the SCCs that are related to Coal
SCC_Coal = SCC[grepl("Coal", SCC$Short.Name),]
dim(SCC_Coal)
# [1] 230  15
length(unique(SCC_Coal$SCC))
# 230
NEI_Coal = subset(NEI, SCC %in% SCC_Coal$SCC)
totalEmissionsCoal = aggregate(Emissions~year, NEI_Coal, FUN=sum)

# Open device
png(filename="plot4.png", width = 700, height = 500)

# barplot data 
barplot(totalEmissionsCoal$Emissions, 
        names.arg=totalEmissionsCoal$year,
        xlab="Year (1999 - 2008)",
        ylab="PM2.5 Emmisions in Tons",
        main="Emissions from coal combustion sources have decreased between 1999-2008.")

# closing device
dev.off()