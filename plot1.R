#Total emissions from PM_{2.5} in the United States from 1999 to 2008
# Need to execute downloadData.R script before running this script

require(dplyr)
# read rds files
SCC <- readRDS(file = "Source_Classification_Code.rds")
NEI <- readRDS(file = "summarySCC_PM25.rds")
# Avoids Scientific Notation
options(scipen=999)
png("plot1.png")
# Group total NEI emissions per year
total.emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
clrs <- c("red", "blue", "yellow","green")
x1<- barplot(height=total.emissions$Emissions/10^5
          , names.arg=total.emissions$year
          , xlab="Years"
          , ylab=expression('Emission (10^5 Tons)')
          , ylim=c(0,80)
          ,main=expression('Total PM'[2.5]*' emissions over the Years')
          ,col=clrs)

## text displayed at top of bars
text(x = x1, y = round(total.emissions$Emissions/10^5,2), label = round(total.emissions$Emissions/10^5,2), pos = 3, cex = 0.8, col = "black")
dev.off()