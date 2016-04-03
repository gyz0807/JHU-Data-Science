classification <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(ggplot2); library(dplyr)

group_type <- summarySCC %>%
        tbl_df() %>%
        filter(fips=="24510") %>%
        mutate(type = as.factor(type)) %>%
        group_by(type, year) %>%
        summarise(sum = sum(Emissions))

png("plot3.png")

ggplot(group_type, aes(year, sum, col = type)) +
        geom_point() +
        geom_line(aes(group_type$year, group_type$sum)) +
        xlab("Year") + ylab("Total PM2.5 Emission") +
        ggtitle("Baltimore City PM2.5 Emission by Type")

dev.off()