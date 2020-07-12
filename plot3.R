# Read data from input file
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, 
                   sep=";",
                   na.strings='?')

get_piece_by_dates <- function(data, dates) {
  data[data$Date %in% dates, ] # Select all rows such that dates are in 'dates' list
}

d <- get_piece_by_dates(data, c("1/2/2007", "2/2/2007"))
# Add extra datetime column
d$Datetime <- strptime(paste(d$Date, d$Time), "%d/%m/%Y %H:%M:%S")
# Get list of minutes
mins <- d$Datetime$min + 60*d$Datetime$hour + 24*60*(d$Datetime$mday-1)

png("plot3.png")
with(d, plot(mins, d$Sub_metering_1, xlab="", ylab="Energy sub metering", 
             xaxt="n", type="n"))

lines(mins, d$Sub_metering_1, col="black")
lines(mins, d$Sub_metering_2, col="red")
lines(mins, d$Sub_metering_3, col="blue")

axis(1, at=c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", lwd=2,
       col=c("black", "red", "blue"),
       legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
dev.off()