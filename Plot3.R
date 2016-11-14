#Plot3 for Project 2
library(ggplot2)
library(dplyr)
NEI<- readRDS("summarySCC_PM25.rds")

#subset Baltimore records

Baltimore<- summarise(group_by(subset(NEI,fips=="24510"),type,year),total=sum(Emissions,na.rm=TRUE))
Baltimore$year<- as.character(Baltimore$year)

plot3<- ggplot(data=Baltimore, aes(x=factor(year), y=total, fill=type, name="Source Type")) + geom_bar(stat="identity", position=position_dodge(),colour="black")
plot3+xlab("Measurement Year")+ylab("Total Emissions")
ggsave(file="plot3.png")
