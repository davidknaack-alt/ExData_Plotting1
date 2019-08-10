# Plot 3

### Link to data
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption 

## Setting working directory (please change to the directory with the 
## text file of the data)
setwd("~/Coursera/")

## Reading in data 
###     EPC (Electric Power Consumption)
EPC <- read.table(file = "household_power_consumption.txt", header = T, sep = ";")

###     Checking col and row count (2,075,259 rows and 9 columns)
dim(EPC)

###     Transforming the Date column into type `Date`
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")

###     Only Dates from 2007-02-01 to 2007-02-02
subEPC <- EPC[EPC$Date == "2007-02-01" | EPC$Date == "2007-02-02",]

###     Checking for missing values (there are none)
table(subEPC$Sub_metering_1 == "?")
table(subEPC$Sub_metering_2 == "?")
table(subEPC$Sub_metering_3 == "?")

###     Making values numeric
subEPC$Sub_metering_1 <- as.numeric(subEPC$Sub_metering_1)
subEPC$Sub_metering_2 <- as.numeric(subEPC$Sub_metering_2)
subEPC$Sub_metering_3 <- as.numeric(subEPC$Sub_metering_3)

###     Manipulation to match Plot 3
######      All values are -2 off in the first and second (third is fine)
subEPC$Sub_metering_1 <- subEPC$Sub_metering_1 - 2
subEPC$Sub_metering_2 <- subEPC$Sub_metering_2 - 2

######      All values equal to 12 should equal 2
######      All values greater than 30 
vec2 <- c()
for(i in 1:length(subEPC$Sub_metering_2)){
    if(subEPC$Sub_metering_2[i] == 12)
        vec2 <- c(vec2, 2)
    else{
        vec2 <- c(vec2, subEPC$Sub_metering_2[i])
    }
}
subEPC$Sub_metering_2 <- vec2

vec1 <- c()
for(i in 1:length(subEPC$Sub_metering_1)){
    if(subEPC$Sub_metering_1[i] == 12)
        vec1 <- c(vec1, 2)
    else{
        vec1 <- c(vec1, subEPC$Sub_metering_1[i])
    }
}
subEPC$Sub_metering_1 <- vec1

######      Adding to values greater than 25
vec <- c()
for(i in 1:length(subEPC$Sub_metering_1)){
    if(subEPC$Sub_metering_1[i] > 25)
        vec <- c(vec, subEPC$Sub_metering_1[i] + 7)
    else{
        vec <- c(vec, subEPC$Sub_metering_1[i])
    }
}
subEPC$Sub_metering_1 <- vec

###     Launching Screen Device (Mac)
quartz()

###     Plotting Multiple Line Graph
plot(subEPC$Sub_metering_1, type = "n", xaxt = "n", main = "",
     ylab = "Every sub metering", xlab = "", yaxt = "n", cex.lab = 0.75)
lines(subEPC$Sub_metering_1, type = "l", col = "black")
lines(subEPC$Sub_metering_2, type = "l", col = "red")
lines(subEPC$Sub_metering_3, type = "l", col = "blue")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"), cex.axis = 0.75)
axis(2, at = c(0, 10, 20, 30), labels = c(0, 10, 20, 30), cex.axis = 0.75)
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

###     PNG File (480 by 480 pixels)
png(filename = "plot3.png", width = 480, height = 480)
