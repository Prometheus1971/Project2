#Plot2 for Project 2
NEI<- readRDS("summarySCC_PM25.rds")

#subset Baltimore records

Baltimore<- subset(NEI,fips=="24510")

#Get total emissons by year
EmissionsByYear<- aggregate(Emissions~year,Baltimore,sum)
EmissionsByYear$year<- as.factor(as.character(EmissionsByYear$year))
png(filename="Plot2.png")
plot(Emissions~year, EmissionsByYear,type="o",col="blue")
lines(lowess(EmissionsByYear))
title("Total Emissions by Year for Baltimore")
dev.off()