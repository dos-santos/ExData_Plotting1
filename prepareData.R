# download  data from web 
downloadFile <- function(fileURL, fname) {
        if(!file.exists(fname)) {
                download.file(fileURL, destfile=fname, mode="wb")
        }
        fname
}


# 1)check if data.csv exists 
#if not download it 
#2) merge date with time to build the daeTime column
prepareData <- function() {
        cacheFile <- "data.csv"
        if(file.exists(cacheFile)) {
                df <- read.csv(cacheFile)
                df$DateTime <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
        }
        else {
                fname <- downloadFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
                con <- unz(fname, "household_power_consumption.txt")
                df <- read.table(con, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
                #close(con)
                df <- df[(df$Date == "1/2/2007") | (df$Date == "2/2/2007"),]
                df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
                write.csv(df, cacheFile)
        }
        df
}