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

##plot the plot on a png file

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(PreciseData$DateTime, PreciseData$Global_active_power, type = "l", xaxt = "n", xlab = ""
     , ylab = "Global Active Power (kilowatts)")

##labels x-axis
axis(1, at = xlabels$xlabels, labels = c("Thu", "Fri", "Sat"))

dev.off()