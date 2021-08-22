#dataset's link
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFile <- "exdata_data_household_power_consumption.zip"

#file path
if (!file.exists(dataFile)) {
        download.file(dataUrl, dataFile, mode = "wb")
}

#unzip the file
dataPath <- "exdata_data_household_power_consumption"
if (!file.exists(dataPath)) {
        unzip(dataFile)
}
#reading the data
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)
colnames(dataset) = c("Date","Time",
                      "Global_active_power",
                      "Global_reactive_power",
                      "Voltage","Global_intensity",
                      "Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3")
#creating line plot
date_time <- strptime(paste(dataset$Date, dataset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
activepower <- as.numeric(dataset$Global_active_power)
reactivepower <- as.numeric(dataset$Global_reactive_power)
Voltage <- as.numeric(dataset$Voltage)
Submeter1 <- as.numeric(dataset$Sub_metering_1)
Submeter2 <- as.numeric(dataset$Sub_metering_2)
Submeter3 <- as.numeric(dataset$Sub_metering_3)

#plotting and converting for graphic device
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
#plot 1
plot(date_time, 
     activepower, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")
#plot 2
plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
#plot 3
plot(date_time, Submeter1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(date_time, Submeter1, col = "black", type = "l")
lines(date_time, Submeter2, col = "red", type = "l")
lines(date_time, Submeter3, col = "blue", type = "l")
legend("topright",
       lty = 1,
       lwd = 2.5,
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#plot 4
plot(date_time, reactivepower, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
