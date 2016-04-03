classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(dplyr)

vehicle_row <- grep(".*[Vv]ehicle.*.*", classification$EI.Sector)
vehicle_scc <- classification[vehicle_row, "SCC"]

group_vihecle <- summarySCC %>%
        tbl_df() %>%
        filter(fips=="24510", SCC %in% vehicle_scc) %>%
        group_by(year) %>%
        summarize(sum = sum(Emissions))

png("plot5.png")

plot(group_vihecle$year, group_vihecle$sum,
     xlab = "Year", ylab = "Total PM2.5 Emission",
     main = "Baltimore City PM2.5 Emission (Motor Vehicle)")
lines(group_vihecle$year, group_vihecle$sum)

fit <- lm(group_vihecle$sum ~ group_vihecle$year)
abline(fit, col = "red", lty=2, lwd=3)

dev.off()