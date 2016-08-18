
#### Download zip folder from website and unzip it 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, mode = "wb")
unzip(temp, "household_power_consumption.txt")

unlink(temp)

#### Read file into data frame and convert numeric variables

power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = FALSE)

power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)


#### Convert date and time into readable formats

datetime <- paste(power$Date, power$Time)

power$CleanedDate <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

sub <- subset(power, as.Date(CleanedDate) >= '2007-02-01' & as.Date(CleanedDate) <= '2007-02-02')


#### Reconstruct second plot in homework assignment and save to plot2.png

plot(sub$CleanedDate,sub$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()