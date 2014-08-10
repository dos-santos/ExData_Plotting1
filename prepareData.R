# download  data if needed

downloadFile <- function(fileURL, fname) {
        if(!file.exists(fname)) {
                download.file(fileURL, destfile=fname, mode="wb")
        }
        fname
}


prepareData <- function() {
        cacheFile <- "data.csv"
        if(file.exists(cacheFile)) {
                tbl <- read.csv(cacheFile)
                tbl$DateTime <- strptime(tbl$DateTime, "%Y-%m-%d %H:%M:%S")
        }
        else {
                fname <- downloadFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
                con <- unz(fname, "household_power_consumption.txt")
                tbl <- read.table(con, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
                #close(con)
                tbl <- tbl[(tbl$Date == "1/2/2007") | (tbl$Date == "2/2/2007"),]
                tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time), "%d/%m/%Y %H:%M:%S")
                write.csv(tbl, cacheFile)
        }
        tbl
}