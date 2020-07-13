#Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California. 
# Which city has seen greater changes over time in motor vehicle emissions
# Need to execute downloadData.R script before running this script

require(dplyr)
require(ggplot2)
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot6.png",width=600,height=480)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles.SCC <- SCC[vehicles,]$SCC
vehicles.NEI <- NEI[NEI$SCC %in% vehicles.SCC,]
citybalt.emissions<-summarise(group_by(filter(vehicles.NEI, fips == "24510"), year), Emissions=sum(Emissions))
citylosangel.emissions<-summarise(group_by(filter(vehicles.NEI, fips == "06037"), year), Emissions=sum(Emissions))

citybalt.emissions$City <- "Baltimore City, Maryland"
citylosangel.emissions$City <- "Los Angeles County, California"
cityboth.emissions <- rbind(citybalt.emissions, citylosangel.emissions)
ggplot(cityboth.emissions, aes(x=factor(year), y=Emissions, fill=City,label = round(Emissions,2))) +
    geom_bar(stat="identity") + 
    facet_grid(scales="free", space="free", .~City) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    ggtitle(expression("PM"[2.5]*" Motor Vehicle(Source) Emissions in Baltimore & Los Angeles, 1999-2008"))+
    geom_label(aes(fill = City),colour = "white", fontface = "bold")
dev.off()










