#Plot4 for Project 2
library(ggplot2)
library(dplyr)
NEI<- readRDS("summarySCC_PM25.rds")


#Load Source Classification Codes for coal combustion related sources
SCC<- readRDS("Source_Classification_Code.rds")
Coal_SCC<- SCC[grep("Coal",SCC$Short.Name),]
CoalCombust_SCC<- Coal_SCC[grep("Fuel Comb",Coal_SCC$EI.Sector),]

#subset  records for coal combustion related sources
CoalCombustNEI<- semi_join(NEI,CoalCombust_SCC,by="SCC")
CoalCombustNEI$year<- as.factor(as.character(CoalCombustNEI$year))

TotalCoalCombustByYear<- aggregate(Emissions~year,CoalCombustNEI,sum)

png(filename="Plot4.png")
plot(Emissions~year, TotalCoalCombustByYear,type="b",pch=18)
lines(lowess(TotalCoalCombustByYear),type="o",col="blue")
title("Total Coal Combustion Emissions by Year")
dev.off()

