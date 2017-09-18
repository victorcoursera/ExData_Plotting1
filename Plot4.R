# Read the data file filtering the dates
install.packages("sqldf")
library(sqldf)
data <- read.csv.sql(".\\data\\household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007'
                     or Date = '2/2/2007'", sep = ";")
closeAllConnections()
data[data == "?"] <- NA
# data <- data[complete.cases(data), ]

# Convert column Date to date type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Create a new column with date and time
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)

# Generate plots
par(mfrow=c(2,2))
# First plot
plot(data$datetime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")
# Second plot
plot(data$datetime, data$Voltage, type = "l", ylab = "Voltage", 
     xlab = "datetime")
# Third plot
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright"
       , c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue")
       ,lty = 1, lwd = 1, cex = 0.7, y.intersp = 0.5, bty="n")
# Fourth plot
plot(data$datetime, data$Global_reactive_power, cex=0.95, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

# Save to png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()