## plot1.R -- A script to create the first plot for Assignment 1 of
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
png(filename = "plot1.png")

# Build the figure
hist(hhpower$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power")

# Close the output device
dev.off()
