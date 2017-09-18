# Read the data file filtering the dates
install.packages("sqldf")
library(sqldf)
data <- read.csv.sql(".\\data\\household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007'
                     or Date = '2/2/2007'", sep = ";")
closeAllConnections()
data[data == "?"] <- NA

# Generate plot
par(mfrow = c(1,1))
hist(data$Global_active_power, main="Global Active Power", 
    xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Save to png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()