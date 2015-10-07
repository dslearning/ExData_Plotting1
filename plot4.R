## Exploratory Data Analysis
## Course Project 1
# This scripts draws 4 diagrams and saves them to png file.

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

## Now we have everything to draw the diagram
#png(filename = "plot4.png", width = 480, height = 480)

## Drawing
# Split graphics devide on two rows and two columns
par(mfrow = c(2, 2))
    
# 1. Draw the 1st diagram (Global Active Power)
plot(x=d$DateTime, y=d$Global_active_power, t="l", main="", xlab="", ylab = "Global Active Power")


# 2. Diagram "Voltage"
plot(x=d$DateTime, y=d$Voltage, t="l", main="", xlab="datetime", ylab = "Voltage")


# 3. Diagram "Energy sub metering"

plot(x=d$DateTime, y=d$Sub_metering_1, t="l", main="", xlab="", ylab = "Energy sub metering", col="black")

lines(x=d$DateTime, y=d$Sub_metering_2, t="l", col="red")
lines(x=d$DateTime, y=d$Sub_metering_3, t="l", col="blue")

# Add legent to diagram 
# Position - top right
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,  lty=1, col=c("black","red", "blue"), bty="n", cex=0.75)


# 4. Diagram "Global Reactive Power"
plot(x=d$DateTime, y=d$Global_reactive_power, t="l", main="", xlab="datetime", ylab = "Global Reactive Power")

# We will save the diagram into file "plot4.png"
dev.copy(png, filename = "plot4.png", width = 480, height = 480)

# Stop drawing and release file

dev.off()
