#Plot5 for Project 2
library(ggplot2)
library(dplyr)
NEI<- readRDS("summarySCC_PM25.rds")


#Load Source Classification Codes for motor vehicle  related sources i.e.Data.Category="Onroad"
SCC<- readRDS("Source_Classification_Code.rds")
motorVehicle_SCC<- SCC[SCC$Data.Category=="Onroad",]


#subset  records for Baltimore
motorVehicleNEI<- semi_join(NEI,motorVehicle_SCC,by="SCC")
motorVehicleNEI$year<- as.factor(as.character(motorVehicleNEI$year))
baltimoreVehicle<- motorVehicleNEI[motorVehicleNEI$fips=="24510",]
TotalVehicleByYear<- aggregate(Emissions~year,baltimoreVehicle,sum)

png(filename="Plot5.png")
plot(Emissions~year, TotalVehicleByYear,type="b",pch=18)
lines(lowess(TotalVehicleByYear),type="o",col="blue")
title("Total Motor Vehicle Emissions for Baltimore by Year")
dev.off()

