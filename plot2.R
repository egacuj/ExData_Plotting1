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
plot(datetimeNumeric, dataSet$Global_active_power, type = "s", xaxt='n', ylab = "Global Active Power (kilowatts)", xlab = "")
pos1 <-  1
pos2 <- length(datetimeNumeric)/2+1
pos3 <- length(datetimeNumeric)

label1 <- as.character(wday(datetime[pos1], label = T, abbr = T)) # Thu
label2 <- as.character(wday(datetime[pos2], label = T, abbr = T)) # Fri
label3 <- as.character(wday(datetime[pos3]+60, label = T, abbr = T)) # Sat

axis(side = 1, at=c(datetimeNumeric[pos1], datetimeNumeric[pos2], datetimeNumeric[pos3]+60),labels=c(label1, label2, label3), col.axis="black", las=0)

dev.copy(png, file = "plot2.png")
dev.off()