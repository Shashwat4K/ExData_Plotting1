
# Read data from input file
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, 
                   sep=";",
                   na.strings='?')

get_piece_by_dates <- function(data, dates) {
  data[data$Date %in% dates, ] # Select all rows such that dates are in 'dates' list
}

d <- get_piece_by_dates(data, c("1/2/2007", "2/2/2007"))

# Plot Histogram according to requirements directly on png file
png("plot1.png")
hist(d$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power")
dev.off()
