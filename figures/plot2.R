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
png("plot2.png", height = 480, width = 480)
plot(date_time, activepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
