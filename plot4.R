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
datetime <- dmy_hms(paste(dataSet[,1],dataSet[,2]))
datetimeNumeric <- as.numeric(datetime)

# prepare xaxis
pos1 <-  1
pos2 <- length(datetimeNumeric)/2+1
pos3 <- length(datetimeNumeric)
label1 <- as.character(wday(datetime[pos1], label = T, abbr = T)) # Thu
label2 <- as.character(wday(datetime[pos2], label = T, abbr = T)) # Fri
label3 <- as.character(wday(datetime[pos3]+60, label = T, abbr = T)) # Sat

par(mfrow = c(2,2))
# figure 1,1
plot(datetimeNumeric, dataSet$Global_active_power, type = "s", xaxt='n', ylab = "Global Active Power", xlab = "")
axis(side = 1, at=c(datetimeNumeric[pos1], datetimeNumeric[pos2], datetimeNumeric[pos3]+60),labels=c(label1, label2, label3), col.axis="black", las=0)

# figure 1,2
plot(datetimeNumeric, dataSet$Voltage, type = "s", col = "black", xaxt='n', ylab = "Voltage", xlab = "datetime")
axis(side = 1, at=c(datetimeNumeric[pos1], datetimeNumeric[pos2], datetimeNumeric[pos3]+60),labels=c(label1, label2, label3), col.axis="black", las=0)
# figure 2,1
plot(datetimeNumeric, dataSet$Sub_metering_1, type = "s", col = "black", xaxt='n', ylab = "Energy sub metering", xlab = "")
points(datetimeNumeric, dataSet$Sub_metering_2, type = "s", col = "red")
points(datetimeNumeric, dataSet$Sub_metering_3, type = "s", col = "blue")
legend("topright", lty = c(1, 1,1), col=c("black", "blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis(side = 1, at=c(datetimeNumeric[pos1], datetimeNumeric[pos2], datetimeNumeric[pos3]+60),labels=c(label1, label2, label3), col.axis="black", las=0)
# figure 2,1
plot(datetimeNumeric, dataSet$Global_reactive_power, type = "s", col = "black", xaxt='n', ylab = "Global_reactive_power", xlab = "datetime")
axis(side = 1, at=c(datetimeNumeric[pos1], datetimeNumeric[pos2], datetimeNumeric[pos3]+60),labels=c(label1, label2, label3), col.axis="black", las=0)
# png copy
dev.copy(png, file = "plot4.png")
dev.off()