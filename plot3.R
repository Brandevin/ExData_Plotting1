library(data.table)
library(lubridate)
#Reading dataset

df<-data.table(read.csv('./household_power_consumption.txt',sep=';',header=TRUE,na.strings='?', 
                        colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')))

#Filtering only relevant data
df$Datetime <- as.Date(df$Date, format= "%d/%m/%Y")
df<-subset(df, Global_active_power!='?'&(Datetime== "2007-02-02" | Datetime== "2007-02-01"))

#Creating column with information about date and time
df$DatetimeHour<-paste(df$Date,df$Time,sep=' ')
df$DatetimeHour <-as.POSIXct(df$DatetimeHour,format="%d/%m/%Y %H:%M:%S")

df[, c("Date","Time",'Datetime'):=NULL]  # remove Date, Time and DateTime columns

#Plot 3
yrange<-range(c(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3))
plot(df$DatetimeHour,df$Sub_metering_1, type="l", col="black", lwd=1,ylab="Energy sub metering",xlab='',ylim=yrange)
par(new=T)
plot(df$DatetimeHour,df$Sub_metering_2, type="l", col="red", lwd=1,xlab='',ylab='',ylim=yrange,axes=F)
par(new=T)
plot(df$DatetimeHour,df$Sub_metering_3, type="l", col="blue", lwd=1,xlab='',ylab='',ylim=yrange,axes=F)
legend('topright',lwd=c(1,1,1),col=c('black','red','blue'),
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.copy(png,filename="plot3.png")
dev.off ()


