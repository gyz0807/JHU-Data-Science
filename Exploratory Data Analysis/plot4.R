classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(dplyr)

coal_row <- grep(".*[Cc]oal.*", classification$EI.Sector)
coal_scc <- classification[coal_row, "SCC"]

group <- summarySCC %>%
        tbl_df() %>%
        filter(SCC %in% coal_scc) %>%
        group_by(year) %>%
        summarize(sum = sum(Emissions))

png("plot4.png")

plot(group$year, group$sum, 
     xlab = "Year", ylab = "Total PM2.5 Emission",
     main = "U.S. Total PM2.5 Emission (Coal Combustion-related)")
lines(group$year, group$sum)

fit <- lm(group$sum ~ group$year)
abline(fit, lty=2, lwd=3, col = "red")

dev.off()