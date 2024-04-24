##Read data into memory and select the necessary data
PowerData <- read.table("household_power_consumption.txt", sep = ";")
PreciseData <- PowerData[66638:69517,]
names(PreciseData) <- c("Date","Time","Global_active_power","Global_reactive_power",
                        "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##plot the plot on a png file

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(PreciseData$Global_active_power), main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()