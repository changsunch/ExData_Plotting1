rm(list = ls())


estimate_memory = 2075259*9*8/(10^6) #MB
data = read.table("household_power_consumption.txt",skip=66637,nrows=2880,sep=";",#
                  na.string="?")
data[,1] = as.character(data[,1])
data[,2] = as.character(data[,2])
names(data) = c("Date","Time","Global_active_power","Global_reactive_power",#
                "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",#
                "Sub_metering_3")
date_time <- paste(data$Date,data$Time)
date_time <- strptime(date_time,format = "%d/%m/%Y %H:%M:%S")
data <- as.data.frame(cbind(date_time,data))
data$Date = NULL #Delete Date column
data$Time = NULL

png("plot4.png",width=480,height=480)
par(bg="transparent")
par(mfrow=c(2,2))
with(data,plot(date_time,Global_active_power,"l",xlab = "",#
                ylab = "Global Active Power"))     
with(data,plot(date_time,Voltage,'l',xlab="datetime",ylab="Voltage"))
with(data,plot(date_time,Sub_metering_1,"l",xlab="",ylab="Energy sub metering"))
with(data,lines(date_time,Sub_metering_2,col="red"))
with(data,lines(date_time,Sub_metering_3,col="blue"))
legend("topright",bty="n",lty=1,col=c("black","red","blue"),#
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(data,plot(date_time,Global_reactive_power,'l',xlab="datetime"))
dev.off()