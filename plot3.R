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

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question. plot3.png

# libs
library(ggplot2)

# prepare data
NeiBaltimore = subset(NEI, fips == "24510")

# Open device
png(filename="plot3.png", width = 800, height = 500)

# ggplot 
ggplot(NeiBaltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  guides(fill=FALSE)+facet_grid(.~type, scales = "free", space="free") + 
  labs(x="Year ", y="Total PM2.5 Emission (Tons)") + 
  labs(title="PM2.5 Emissions by Source, Baltimore City, ML: slight POINT increase vs general decreases")

# closing device
dev.off()