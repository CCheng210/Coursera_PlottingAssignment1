library(tidyverse)
library(ggplot2)
##Read data into memory and select the necessary data
PowerData <- read.table("household_power_consumption.txt", sep = ";")
PreciseData <- PowerData[66638:69517,]
names(PreciseData) <- c("Date","Time","Global_active_power","Global_reactive_power",
                        "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
##Merge Date and Time
DateTime <- paste(PreciseData$Date, PreciseData$Time)
DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")
DateTime <- as.data.frame(DateTime)
PreciseData <- cbind(DateTime, PreciseData)
PreciseData <- select(PreciseData, -Date, -Time)
xlabels <- strptime(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), format = "%Y-%m-%d %H:%M:%S")
xlabels <- as.data.frame(xlabels)
##plot the plot on a png file

png(filename = "plot4.png", width = 480, height = 480, units = "px")

## 4 figures in a 2x2 formation
par(mfrow = c(2,2))

##figure 1
plot(PreciseData$DateTime, PreciseData$Global_active_power, type = "l", xaxt = "n", xlab = ""
        , ylab = "Global Active Power")
axis(1, at = xlabels$xlabels, labels = c("Thu", "Fri", "Sat"))

##figure 2
plot(PreciseData$DateTime, PreciseData$Voltage, type = "l", xaxt = "n",
      xlab = "datetime", ylab = "Voltage")
axis(1, at = xlabels$xlabels, labels = c("Thu","Fri","Sat"))

##figure 3
##plots lines
plot(PreciseData$DateTime, PreciseData$Sub_metering_1, type = "l", xaxt = "n", 
     xlab = "" , ylab = "Energy sub metering")
lines(PreciseData$DateTime, PreciseData$Sub_metering_2, col = "red")
lines(PreciseData$DateTime, PreciseData$Sub_metering_3, col = "blue")
##labels x-axis
axis(1, at = xlabels$xlabels, labels = c("Thu", "Fri", "Sat"))
##creates legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1, bty = "n")

##figure 4
plot(PreciseData$DateTime, PreciseData$Global_reactive_power, type = "l", xaxt = "n", 
     xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at = xlabels$xlabels, labels = c("Thu", "Fri", "Sat"))
dev.off()


