# Of the four types of sources indicated by the type= (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases/increases in
# emissions from 1999-2008 for Baltimore City
# Need to execute downloadData.R script before running this script

require(dplyr)
require(ggplot2)
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot3.png",width=600,height=480)
# Group total NEI emissions per year where fips is equal to 24510
citybalt.emissions<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))
ggplot(citybalt.emissions, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type,scales = "free",space="free") +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    ggtitle(expression("PM"[2.5]* " Emissions, Baltimore City 1999-2008 by Source Type", sep=""))+
    geom_label(aes(fill = type), colour = "white", fontface = "bold")
dev.off()