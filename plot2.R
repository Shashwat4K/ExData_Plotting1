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

png("plot2.png")
with(d, plot(mins, d$Global_active_power, 
             xlab="", ylab="Global Active Power (kilowatts)",
             xaxt='n', type="l"))
# Since all the data is per minute, we have to label the x axis with 'days'
# Therefore the values 1, 1440, 2880
axis(side=1, at = c(1, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
dev.off()