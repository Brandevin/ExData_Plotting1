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

#Plot 2
plot(df$DatetimeHour,df$Global_active_power, type="l", col="black", lwd=1,ylab="Global Active Power (kilowatts)",xlab='')
dev.copy(png,filename="plot2.png")
dev.off ()
          
          