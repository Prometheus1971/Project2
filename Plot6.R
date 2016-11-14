#Plot 6 Project 2
library(dplyr)
NEI<- readRDS("summarySCC_PM25.rds")


#Get motor vehicle classification codes
SCC<- readRDS("Source_Classification_Code.rds")
motorVehicle_SCC<- SCC[SCC$Data.Category=="Onroad",]

#Get motor vehicle emissions
motorVehicleNEI<- semi_join(NEI,motorVehicle_SCC,by="SCC")
motorVehicleNEI$year<- as.factor(as.character(motorVehicleNEI$year))

#Get Baltimore emissions
baltimoreVehicle<- motorVehicleNEI[motorVehicleNEI$fips=="24510",]
baltimoreVehicleByYear<- aggregate(Emissions~year,baltimoreVehicle,sum)
baltimoreVehicleByYear$year<- as.factor(as.character(baltimoreVehicleByYear$year))

#Get Los Angeles County emmisions
losAngelesVehicle<- motorVehicleNEI[motorVehicleNEI$fips=="06037",]
losAngelesVehicleByYear<- aggregate(Emissions~year,losAngelesVehicle,sum)
losAngelesVehicleByYear$year<- as.factor(as.character(losAngelesVehicleByYear$year))


png(filename="Plot6.png")
par(mfrow=c(1,2))
plot(Emissions~year, baltimoreVehicleByYear,pch=18)
lines(lowess(baltimoreVehicleByYear),type="o",col="blue")
title("Baltimore")

plot(Emissions~year, losAngelesVehicleByYear,pch=18)
lines(lowess(losAngelesVehicleByYear),type="o",col="red")
title("Los Angeles")
dev.off()




