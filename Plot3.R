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
EPC_filt$Sub_metering_1 <- as.numeric(as.character(EPC_filt$Sub_metering_1))
EPC_filt$Sub_metering_2 <- as.numeric(as.character(EPC_filt$Sub_metering_2))
EPC_filt$Sub_metering_3 <- as.numeric(as.character(EPC_filt$Sub_metering_3))
class(EPC_filt$DateTime)

#test before printing to png
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

#PNG file
png(filename = "C:/RWorkingDir-DMF/CourseRA/Course4/Week1/Plot3.png", 
    width = 480, height = 480, 
    units= "px")
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
dev.off()