## plot4.R -- A script to create the fourth plot for Assignment 1 of
## the Coursera Exploratory Data Analysis course
## Tod Wright 7 August 2016

# Download and unpack the data set, if necessary
if (!file.exists("household_power_consumption.txt")) {
    fileURL <- paste("http://d396qusza40orc.cloudfront.net/",
                     "exdata%2Fdata%2Fhousehold_power_consumption",
                     ".zip", sep="")
    zipfile <- "household_power_consumption.zip"
    download.file(fileURL, destfile=zipfile, method="curl")
    unzip(zipfile)
}

# Load the data into a data frame
hhpower <- read.table("household_power_consumption.txt",
                      header=TRUE, sep=";", na.strings="?",
                      stringsAsFactors=FALSE)

# Merge the date and time information together and convert it to
# POSIX format
hhpower$Time <- paste(hhpower$Date, hhpower$Time)
hhpower <- hhpower[,-1]
hhpower$Time <- strptime(hhpower$Time, format="%d/%m/%Y %H:%M:%S")

# Select only data for the two days of interest
hhpower <- subset(hhpower, as.Date(Time)=="2007-02-01"
                         | as.Date(Time)=="2007-02-02")

# Open a .png file for output
png(filename = "plot4.png")

# Make an array of four panels
par(mfrow=c(2,2))

# Build the first panel
plot(hhpower$Time, hhpower$Global_active_power, type="n",
     xlab="", ylab="Global Active Power")
lines(hhpower$Time, hhpower$Global_active_power)

# Build the second panel
plot(hhpower$Time, hhpower$Voltage, type="n",
     xlab="datetime", ylab="Voltage")
lines(hhpower$Time, hhpower$Voltage)

# Build the third panel
plot(hhpower$Time, hhpower$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(hhpower$Time, hhpower$Sub_metering_1, col="black")
lines(hhpower$Time, hhpower$Sub_metering_2, col="red")
lines(hhpower$Time, hhpower$Sub_metering_3, col="blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=c(1,1,1), bty="n")

# Build the fourth panel
plot(hhpower$Time, hhpower$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(hhpower$Time, hhpower$Global_reactive_power)

# Close the output device
dev.off()
