library(dplyr)
library(lubridate)
setwd("D:/EspecDataScience/CURSO 4 EXPLORATORY DATA ANALYSIS/S1-BasicGraphs/Proyecto1")
df <- tbl_df(read.csv2(file = "./household_power_consumption.txt", na.strings = c("?","")))

# Creates datetime column and filters the required dates -----------
df <- df %>%
        mutate(Date=paste(Date,Time)) %>%
        select(-Time) %>%
        rename(datetime=Date) %>%
        mutate(datetime=dmy_hms(datetime)) %>%
        filter(datetime >= ymd_hms("2007-02-01 00:00:00") & datetime <= ymd_hms("2007-02-02 23:59:59"))
df[,2:8] <- lapply(df[,2:8],as.character)
df[,2:8] <- lapply(df[,2:8],as.numeric)

# Creates the grid to plot -----------
par(mfrow=c(2,2))

# First plot
with(df, plot(datetime, Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power"))

# Second plot
with(df, plot(datetime, Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage"))

# Third plot
with(df, plot(datetime, Sub_metering_1, col="gray",
     type="l",
     xlab="",
     ylab="Energy sub metering"))
with(df, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(df, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
with(df, legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("gray","red","blue"), lwd = 2, bty = "n", cex=0.5))

# Fourth plot
with(df, plot(datetime, Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power"))

# Prints plot to png
dev.copy(png,'plot4.png', width = 480, height = 480)
dev.off()