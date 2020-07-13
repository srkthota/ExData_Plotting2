# Across the United States, how have emissions from coal combustion-related
#  sources changed from 1999-2008
# Need to execute downloadData.R script before running this script

require(dplyr)
require(ggplot2)
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot4.png")
comb.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
comb.coal.scc <- SCC[comb.coal,]

# Find emissions from coal combustion
comb.coal.NEI <- NEI[(NEI$SCC %in% comb.coal.scc$SCC), ]
comb.emissions <- summarise(group_by(comb.coal.NEI, year), Emissions=sum(Emissions))
ggplot(comb.emissions, aes(x=factor(year), y=Emissions/10^5,fill=year, label = round(Emissions/10^5,2))) +
geom_bar(stat="identity") +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    ggtitle(expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()
