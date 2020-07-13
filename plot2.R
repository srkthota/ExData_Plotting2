#Total emissions from PM_{2.5} in the Baltimore City, Maryland from 1999 to 2008
# Need to execute downloadData.R script before running this script

require(dplyr)
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot2.png")
# Group total NEI emissions per year where fips is equal to 24510
citybalt.emissions<-summarise(group_by(filter(NEI, fips == "24510"), year), Emissions=sum(Emissions))
clrs <- c("red", "blue", "yellow","green")
x2<-barplot(height=citybalt.emissions$Emissions/10^2
            , names.arg=citybalt.emissions$year
            , xlab="Years"
            , ylab=expression('Emissions(10^2 Tons)')
            , ylim=c(0,40)
            , main=expression('Total PM'[2.5]*' emissions in Baltimore City'),col=clrs)

## text displayed at top of bars
text(x = x2, y = round(citybalt.emissions$Emissions/10^2,2), label = round(citybalt.emissions$Emissions/10^2,2), pos = 3, cex = 0.8, col = "black")
dev.off()