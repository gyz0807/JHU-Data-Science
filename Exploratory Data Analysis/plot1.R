classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(dplyr)

group <- summarySCC %>%
        group_by(year) %>%
        summarise(sum = sum(Emissions))

png("plot1.png")

plot(group$year, group$sum, xlab = "Year", ylab = "Total PM2.5 Emission", 
     main = "United States PM2.5 Emission")
lines(group$year, group$sum)

fit <- lm(group$sum ~ group$year)
abline(fit, lty=3, col = "red", lwd=2)

dev.off()