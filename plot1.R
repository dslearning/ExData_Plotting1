## Exploratory Data Analysis
## Course Project 1
# This scripts draws histogram "Global Active Power" and saves it to png file.

# Libridate is used for date-manupulation functions (like YMD, HMS) 
library(lubridate)

#Dplyr is used for data-frame manipulation (select, mutate, filter, etc)
library(dplyr)

# Loading data, convert characters into date, filter the result set
# Filter:
#   Date >= 2007-02-01 and
#   Date < 2007-02-03 (2007-02-02 23:59:59.999)

d <- 
  read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings = "?") %>%
  mutate( DateTime=dmy_hms(paste(Date, Time, sep=" "), tz = "UTC")) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") & DateTime < ymd("2007-02-03")) %>%
  select( DateTime, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3)

## Now we have everything to draw the histogram

# Drawing
hist(d$Global_active_power, col="red", main="Global Active Power", ylim = c(0,1200), xlab = "Global Active Power (kilowatts)", ylab="Frequency")

# We will save the historam into file "plot1.png"
dev.copy(png, filename = "plot1.png", width = 480, height = 480)

# Stop drawing and release file
dev.off()
