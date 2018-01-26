library(dplyr)
library(lubridate)
df <- tbl_df(read.csv2(file = "./household_power_consumption.txt", na.strings = c("?","")))

# Creates datetime column and filters the required dates
df <- df %>%
        mutate(Date=paste(Date,Time)) %>%
        select(-Time) %>%
        rename(datetime=Date) %>%
        mutate(datetime=dmy_hms(datetime)) %>%
        filter(datetime >= ymd_hms("2007-02-01 00:00:00") & datetime <= ymd_hms("2007-02-02 23:59:59"))
df[,2:8] <- lapply(df[,2:8],as.character)
df[,2:8] <- lapply(df[,2:8],as.numeric)

# Creates plot -----------
with(df, plot(datetime, Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)"))

# Prints plot to png
dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()
