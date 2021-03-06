# perepare data
#download data if necessary
source("prepareData.R")

#plot plot2.png
doPlot2 <- function() {
        df <- prepareData()
        png(filename = "plot2.png", width = 480, height = 480, units = "px")
        plot(df$DateTime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.off()
}

doPlot2()