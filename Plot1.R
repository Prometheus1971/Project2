#Plot1 for Project 2
NEI<- readRDS("summarySCC_PM25.rds")

#Get mean emissons by year
EmissionsByYear<- aggregate(Emissions~year,NEI,sum)

EmissionsByYear$year<- as.factor(as.character(EmissionsByYear$year))

png(filename="Plot1.png")
plot(Emissions~year, EmissionsByYear,type="b",pch=18)
lines(lowess(EmissionsByYear),type="o",col="blue")
title("Total Emissions by Year")
dev.off()