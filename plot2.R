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
dataSet <- subset(dataSet, Date == "1/2/2007" | Date == "2/2/2007")
datetime <- strptime(paste(dataSet$Date, dataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
plot(datetime, dataSet$Global_active_power, type = "s", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png")
dev.off()