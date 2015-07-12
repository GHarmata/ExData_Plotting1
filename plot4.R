# Project 1, Plot 4
## Exploratory Data Analysis

##### NOTES: 
##### Steps 1 and 2 are the same for each of the plots in this project. 

##### If the dataset has already been downloaded and unzipped, feel free to skip 
##### Step 1; however, if you do skip this step, make sure that the data file 
##### "household_power_consumption.txt" is in your working directory.  

##### If the dataset has already been loaded into R and modified exactly as
##### specified in Step 2 (i.e., one of the other scripts in this repo has
##### already been run and data3 exists in the current Global
##### Environment), feel free to proceed to Step 3.


### Step 1: Download the dataset 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              "power-consumption.zip", method="curl") 
unzip("power-consumption.zip")


### Step 2: Load the dataset, fix the date/time format, and subset the
### appropriate dates; also remove intermediate objects to free up memory.
read.table("household_power_consumption.txt", 
           header = TRUE, sep = ";", as.is = TRUE, na.strings = "?") -> data

paste(data$Date, data$Time) -> datetime
cbind(datetime, data[ , 3:9]) -> data2
rm(data)
strptime(data2$datetime, "%d/%m/%Y %H:%M:%S") -> data2$datetime

sapply(c(day1 = "2007-02-01", day2 = "2007-02-02"), grepl, x = data2$datetime) -> subset
as.data.frame(subset) -> subset
subset$day1 | subset$day2 -> finalsub
data2[finalsub, ] -> data3
rm(data2, subset, finalsub)


### Step 3: Create the target plot and write the png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

##### Plot A
with(data3, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

##### Plot B
with(data3, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(data3, {
    lines(datetime, Sub_metering_1, col = "black", type = "l")
    lines(datetime, Sub_metering_2, col = "red", type = "l")
    lines(datetime, Sub_metering_3, col = "blue", type = "l")
})

##### Plot C
with(data3, plot(datetime, Voltage, type = "l"))

##### Plot D
with(data3, plot(datetime, Global_reactive_power, type = "l"))

dev.off()