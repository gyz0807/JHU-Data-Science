classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

plyr)

baltimore <- summarySCC %>%
        tbl_df() %>%
        filter(fips=="24510") %>%
        group_by(year) %>%
        summarise(sum = sum(Emissions))

png("plot2.png")

plot(baltimore$year, baltimore$sum)
lines(b, xlab = "Year", ylab = "Total PM2.5 Emission",
     main = "Baltimore City PM2.5 Emission"altimore$year, baltimore$sum)

fit <- lm(baltimore$sum ~ baltimore$year)
abline(fit, col = "red", lty = 3, lwd=

dev.off()