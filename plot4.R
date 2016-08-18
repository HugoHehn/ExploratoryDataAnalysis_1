
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


#### Reconstruct fourth plot in homework assignment and save to plot4.png

par(mfrow=c(2,2))

plot(sub$CleanedDate,sub$Global_active_power, type="l", ylab="Global Active Power", xlab="")

plot(sub$CleanedDate,sub$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(sub$CleanedDate,sub$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(sub$CleanedDate, sub$Sub_metering_2, col="red")
lines(sub$CleanedDate, sub$Sub_metering_3, col="blue")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty="n", cex=0.6) 

plot(sub$CleanedDate, sub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()