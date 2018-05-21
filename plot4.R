## Download the zip file, more instructions see 
## https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-downloadingFiles.md

if(!file.exists("data.zip")) {
    dlMethod <- "curl" # sets default for OSX / Linux
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    if(substr(Sys.getenv("OS"),1,7) == "Windows") dlMethod <- "wininet"
        download.file(url,
              "data.zip",  # stores file in R working directory
              method=dlMethod, # use OS-appropriate method
              mode="wb")        # binary for zip
}
if(!file.exists("household_power_consumption.txt")){
    unzip(zipfile = "data.zip")
}

# read data
dataSet <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F) #
library(lubridate)
dataSet <- subset(dataSet, Date == "1/2/2007" | Date == "2/2/2007")



par(mfrow = c(2,2))
# figure 1,1
plot(datetime <- strptime(paste(dataSet$Date, dataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S"), dataSet$Global_active_power, type = "s",  ylab = "Global Active Power", xlab = "")


# figure 1,2
plot(datetime, dataSet$Voltage, type = "s", col = "black", ylab = "Voltage", xlab = "datetime")

# figure 2,1
plot(datetime, dataSet$Sub_metering_1, type = "s", col = "black", ylab = "Energy sub metering", xlab = "")
points(datetime, dataSet$Sub_metering_2, type = "s", col = "red")
points(datetime, dataSet$Sub_metering_3, type = "s", col = "blue")
legend("topright", lty = c(1, 1,1), col=c("black", "blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# figure 2,1
plot(datetime, dataSet$Global_reactive_power, type = "s", col = "black", ylab = "Global_reactive_power", xlab = "datetime")

# png copy
dev.copy(png, file = "plot4.png")
dev.off()