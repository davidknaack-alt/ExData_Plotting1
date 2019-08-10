# Plot 2

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
table(subEPC$Global_active_power == "?")

###     Making values numeric
GAP <- (as.numeric(subEPC$Global_active_power)/1000) * 2

###     Launching Screen Device (Mac)
quartz()

###     Plotting Line Graph
plot(GAP, main = "", type = "l", xlab = "", xaxt = "n",
     ylab = "Global Active Power (kilowatts)", cex.lab = 0.75, cex.axis = 0.75)

### Adding the x-axis labels
axis(1, at= c(0, 1441, 2881), labels = c("Thu", "Fir", "Sat"))

###     PNG File (480 by 480 pixels)
png(filename = "plot2.png", width = 480, height = 480)
