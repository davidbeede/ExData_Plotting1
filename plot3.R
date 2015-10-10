#plot2.R written by David Beede for Exploratory Data Analysis
#replicates plot 3 of programming assingment 1

#determine column types before reading entire file
tab5rows <- read.table("household_power_consumption.txt", 
                       header = TRUE, nrows = 5, sep = ";")
str(tab5rows)
#read in entire file
library(readr)
tabAllHPC <- read_csv2("household_power_consumption.txt", na = "?", 
                       col_types = "ccnnnnnnn", col_names = TRUE)
library(dplyr)
#create date class variable from date string variable
#to filter out all dates except for Feb 1-2, 2007
tabAllHPC <- mutate(tabAllHPC, newDate = as.Date(Date, "%d/%m/%Y"))
tabFeb2007HPC <- filter(tabAllHPC, newDate == as.Date(ISOdate(2007,2,1))
        | newDate == as.Date(ISOdate(2007,2,2)))

#following line inspired by discussion of Michael Jackson
# at https://class.coursera.org/exdata-033/forum/thread?thread_id=15
#create POSIXct formatted date and time for sorting
tabFeb2007HPC$newDateTime <- as.POSIXct(strptime(paste(tabFeb2007HPC$Date,tabFeb2007HPC$Time), 
        "%d/%m/%Y %H:%M:%S"))
tabFeb2007HPC <- arrange(tabFeb2007HPC, newDateTime)

par(pin = c(6,5), mar = c(5, 5, 4, 2))
with(tabFeb2007HPC, plot(newDateTime, Sub_metering_1, type = "l",
        ylab = "Energy sub metering", xlab = "", 
        font.lab = 2, cex.lab = 0.8, font.axis = 2, cex.axis = 0.8))
with(tabFeb2007HPC, lines(newDateTime, Sub_metering_2, col = "red"))
with(tabFeb2007HPC, lines(newDateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

png(file = "plot3.png", width = 480, height = 480, type = "windows")
par(pin = c(6,5), mar = c(5, 5, 4, 2))
with(tabFeb2007HPC, plot(newDateTime, Sub_metering_1, type = "l",
       ylab = "Energy sub metering", xlab = "", 
       font.lab = 2, cex.lab = 0.8, font.axis = 2, cex.axis = 0.8))
with(tabFeb2007HPC, lines(newDateTime, Sub_metering_2, col = "red"))
with(tabFeb2007HPC, lines(newDateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

