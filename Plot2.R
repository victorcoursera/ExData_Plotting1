# Read the data file filtering the dates
install.packages("sqldf")
library(sqldf)
data <- read.csv.sql(".\\data\\household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007'
                     or Date = '2/2/2007'", sep = ";")
closeAllConnections()
data[data == "?"] <- NA

# Convert column Date to date type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Create a new column with date and time
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)

# Generate plot
par(mfrow = c(1,1))
plot(data$Global_active_power ~ data$datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

# Save to png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()