#download, unzip, and convert to csv
EPC<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(EPC,destfile = "C:/RWorkingDir-DMF/CourseRA/Course4/Week1/EPC.zip")
unzip("C:/RWorkingDir-DMF/CourseRA/Course4/Week1//EPC.zip", exdir= "C:/RWorkingDir-DMF/CourseRA/Course4/Week1/EPC_Data")
EPC_CSV<-read.csv("C:/RWorkingDir-DMF/CourseRA/Course4/Week1/EPC_Data/household_power_consumption.txt", header = TRUE, sep = ";")
class(EPC_CSV$Date)

#convert date field to data format
EPC_CSV$Date <- as.Date(EPC_CSV$Date, format = "%d/%m/%Y")


#filter to only 2 dates used and convert formats
EPC_filt<-subset(EPC_CSV, Date == '2007-02-01' | Date == '2007-02-02')
EPC_filt$DateTime <- as.POSIXct(paste(EPC_filt$Date, EPC_filt$Time))
EPC_filt$Global_active_power <- as.numeric(as.character(EPC_filt$Global_active_power))
EPC_filt$Global_reactive_power <- as.numeric(as.character(EPC_filt$Global_reactive_power))
EPC_filt$Voltage <- as.numeric(as.character(EPC_filt$Voltage))
EPC_filt$Sub_metering_1 <- as.numeric(as.character(EPC_filt$Sub_metering_1))
EPC_filt$Sub_metering_2 <- as.numeric(as.character(EPC_filt$Sub_metering_2))
EPC_filt$Sub_metering_3 <- as.numeric(as.character(EPC_filt$Sub_metering_3))
class(EPC_filt$DateTime)

#test before printing to png
par(mfrow = c(2,2))
plot(EPC_filt$DateTime,EPC_filt$Global_active_power, 
     type = "l",
     xlab = "",
     ylab="Global Active Power")
plot(EPC_filt$DateTime,EPC_filt$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab="Voltage")
plot(EPC_filt$DateTime,
     EPC_filt$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab="Energy sub metering")
lines(EPC_filt$DateTime, 
      EPC_filt$Sub_metering_2,
      col= "red")
lines(EPC_filt$DateTime, 
      EPC_filt$Sub_metering_3,
      col= "blue")
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1))
plot(EPC_filt$DateTime,EPC_filt$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab="Global_reactive_power")


#PNG file
png(filename = "C:/RWorkingDir-DMF/CourseRA/Course4/Week1/Plot4.png", 
    width = 480, height = 480, 
    units= "px")
with(EPC_filt,
     par(mfrow = c(2,2), mar= c(4,4,2,1), oma= c(0.0,2,0)),
     plot(Global_active_power~DateTime, 
          type = "l",
          xlab = "",
          ylab="Global Active Power")
     plot(Voltage~DateTime, 
          type = "l",
          xlab = "datetime",
          ylab="Voltage")
     plot(EPC_filt$DateTime,
          EPC_filt$Sub_metering_1, 
          type = "l",
          xlab = "",
          ylab="Energy sub metering")
     lines(EPC_filt$DateTime, 
           EPC_filt$Sub_metering_2,
           col= "red")
     lines(EPC_filt$DateTime, 
           EPC_filt$Sub_metering_3,
           col= "blue")
     legend("topright", 
            col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
            lty = c(1,1,1))
     plot(Global_reactive_power~DateTime, 
          type = "l",
          xlab = "datetime",
          ylab="Global_reactive_power"))
dev.off()