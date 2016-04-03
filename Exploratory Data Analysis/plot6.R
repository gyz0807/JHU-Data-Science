classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(dplyr)

vehicle_row <- grep(".*[Vv]ehicle.*.*", classification$EI.Sector)
vehicle_scc <- classification[vehicle_row, "SCC"]

group_BCLA <- summarySCC %>%
        tbl_df() %>%
        filter(fips %in% c("06037", "24510"), SCC %in% vehicle_scc) %>%
        mutate(fips = as.factor(fips)) %>%
        group_by(fips, year) %>%
        summarize(sum = sum(Emissions))

png("plot6.png")

plot(group_BCLA$year, group_BCLA$sum, col = group_BCLA$fips,
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emission"),
     main = "Total PM2.5 Emission (Motor Vehicle)")
lines(group_BCLA$year[group_BCLA$fips=="06037"], 
      group_BCLA$sum[group_BCLA$fips=="06037"])
lines(group_BCLA$year[group_BCLA$fips=="24510"], 
      group_BCLA$sum[group_BCLA$fips=="24510"], col = "red")
legend("center", legend = c("Los Angeles County", "Baltimore City"), bty="n",
       col = c("black", "red"), lty = 1)

dev.off()