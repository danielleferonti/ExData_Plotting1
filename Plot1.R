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
EPC_filt$Global_active_power <- as.numeric(as.character(EPC_filt$Global_active_power))
class(EPC_filt$Global_active_power)

#test before printing to png
hist(EPC_filt$Global_active_power,
     main = "Global Active Power",
     xlab= "Global Active Power (kilowatts)",
     ylab= "Frequency",
     col = "red")

#PNG file
png(filename = "C:/RWorkingDir-DMF/CourseRA/Course4/Week1/Plot1.png", 
    width = 480, height = 480, 
    units= "px")
with(EPC_filt, 
     hist(Global_active_power, 
          xlab = 'Global Active Power (kilowatts)', 
          main = 'Global Active Power', 
          col = 'red'))
dev.off()