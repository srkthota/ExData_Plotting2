#How have emissions from motor vehicle sources changed from 
#1999-2008 in Baltimore City
# Need to execute downloadData.R script before running this script

require(dplyr)
require(ggplot2)
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot5.png")
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles.SCC <- SCC[vehicles,]$SCC
vehicles.NEI <- NEI[NEI$SCC %in% vehicles.SCC,]
citybalt.emissions<-summarise(group_by(filter(vehicles.NEI, fips == "24510"), year), Emissions=sum(Emissions))
citybalt.emissions$City <- "Baltimore City, Maryland"
ggplot(citybalt.emissions, aes(x=factor(year), y=Emissions, fill=year, label = round(Emissions,2))) +
 geom_bar(stat="identity") +
 facet_grid(scales="free", space="free", .~year) +
 guides(fill=FALSE) + theme_bw() +
 labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
 ggtitle(expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore , 1999-2008"))+
 geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()
