# load Required For the Analysis
library(ggplot2) # for visualisation
library(tidyverse) # For data wrangling 
library(lubridate) # For time 
 library(data.table)# for exporting data

# Load Dataset 
Annual_data <- read_csv("combine.csv")
# View first ten row of the dataset
tibble(Annual_data)
# Count the number  of meet
sum(is.na(Annual_data))

# Check number of row and column
nrow(Annual_data)
ncol(Annual_data)
# check column name and data types
dim(Annual_data)
colnames(Annual_data)
# Add columns thst list the date month, year,hour and week days of each ride
Annual_data$date <- as.Date(Annual_data$started_at)
Annual_data$month <- format(as.Date(Annual_data$date), "%m")
Annual_data$year <- format(as.Date(Annual_data$date),"%Y")
Annual_data$week_days <- format(as.Date(Annual_data$date),"%A")
Annual_data$ride_hours <- format(as.POSIXct(Annual_data$started_at), format = "%H")
# Add a route column to show most used station by riders
annual_data_clean$route <- paste(annual_data_clean$start_station_name, "_to_", annual_data_clean$end_station_name)

head(annual_data_clean$route, annual_data_clean$member_casual)
# Add a column to calculate Ride_length in minutes
Annual_data$ride_length <- difftime(Annual_data$ended_at, Annual_data$started_at, units = "mins")
# verify week days column
table(Annual_data$week_days, Annual_data$month)
glimpse(Annual_data)
# convert ride_length from factor to numeric to perform calculation
Annual_data$ride_length <- as.numeric(as.character(Annual_data$ride_length))
# check ride_length column for confirmation
is.numeric(Annual_data$ride_length)
# drop All column that is not needed for the analysis
Annual_data_v1 <- Annual_data %>%  select(-c(end_lat,start_lng,start_lat,end_lng))

colnames(Annual_data_v1)
# Remove null value from the dataset 
Annual_data_v2 <- na.omit(Annual_data_v1)
summary(Annual_data_v1$ride_length)
# remove negative value from ride_length
annual_data_clean <- Annual_data_v2[!(Annual_data_v2$start_station_name == "HQ QR" | Annual_data_v2$ride_length<0),]
glimpse(annual_data_clean)

# compare both member and casual ride length
aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual, FUN = mean)

aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual, FUN = median)
aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual, FUN = max)
aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual, FUN = min)
# Arrange the days in a formats that is generally recognised
annual_data_clean$week_days <- ordered(annual_data_clean$week_days, level = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
view(annual_data_clean$week_days)
# Average rides length by each member in each day
average_rides <- aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual + annual_data_clean$week_days, FUN = mean)
view(average_rides)
# Average ride length by each member in each hour
average_rides_hour <-aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual+annual_data_clean$ride_hours, FUN = mean)
# Average rides length by each member in each month
average_rides_month <- aggregate(annual_data_clean$ride_length~annual_data_clean$member_casual+annual_data_clean$month, FUN = mean)
view(average_rides_month)

# Numbers of rides of each rider type over the days
number_of_rides_day <-annual_data_clean %>% 
  mutate(week_days) %>% 
  group_by(member_casual,week_days) %>% 
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual,week_days)
#number of each riders type over the days viz
ggplot(data = number_of_rides_day)+aes(x = week_days, y = number_of_rides,fill = member_casual)+geom_col(position = "dodge")
# number  of each ride type over the months
number_of_rides_month <-annual_data_clean %>% 
  mutate(month) %>%
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual,month)
# number of each rides in month viz
ggplot(data = number_of_rides_month)+aes(x = month, y = number_of_rides,fill = member_casual)+geom_col(position = "dodge")
# number of each rides type over the hours
number_of_rides_hour <-annual_data_clean %>% 
  mutate(ride_hours) %>%
  group_by(member_casual,ride_hours) %>% 
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual,ride_hours)
view(number_of_rides_hour)  
# number of each rides type in hour chart
ggplot(data = number_of_rides_hour)+aes(x = ride_hours, y = number_of_rides,fill = member_casual)+geom_col(position = "dodge")
# Casual riders Data frame
member_riders_routes <- annual_data_clean %>% 
  filter(member_casual == "member") %>%
  group_by(route) %>%
  summarise(avg_duration = mean(ride_length), number_of_trips = n(), .groups = "keep") %>%
  arrange(-number_of_trips) %>% 
  head(10)
  
# Casual riders route Viz
annual_data_clean %>%
  filter(member_casual == "casual") %>%
  group_by(route) %>%
  summarise(avg_duration = mean(ride_length), number_of_trips = n(), .groups = "keep") %>%
  arrange(-number_of_trips) %>%
  head(5) %>%
  ggplot(aes(x=reorder(route, +number_of_trips), y=number_of_trips))+
  geom_bar(stat = "identity", fill="sky blue")+
  theme_minimal()+
  coord_flip()




# Number of rides by rideable type

number_of_ride_rideable_type <-annual_data_clean %>% 
  mutate(rideable_type) %>% 
  group_by(member_casual,rideable_type) %>% 
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  
  # Number of rides by rideable type
  ggplot(data = number_of_ride_rideable_type)+aes(x = rideable_type, y = number_of_rides,fill = member_casual) + geom_col(position = "dodge")

# Ride length greater 24 hours
long_ride <- annual_data_clean %>% 
  select(ride_length, member_casual ,rideable_type) %>% 
  filter(ride_length >= 1440 ) 
# Ride length less than 24 hrs 
short_ride <- annual_data_clean %>% 
  select(ride_length, member_casual ,rideable_type) %>% 
  filter(ride_length < 1440 ) 
# percentage of rides length less than 24 hrs
p_Of_Ride_length_g24 <- short_ride %>% 
  group_by( member_casual ) %>% 
  summarise( percent = 100 * n() / nrow( short_ride ) ) 
  
# percentage of rides length greater than 24 hrs
p_Of_Ride_length_grt24 <- long_ride %>% 
  group_by( member_casual ) %>% 
  summarise( percent = 100 * n() / nrow( long_ride ) )  

annual_data_clean %>% 
  select(ride_length, member_casual ,rideable_type) %>% 
  filter(ride_length>=1440 ) %>% 
  arrange(ride_length)

aggregate(annual_data_clean$ride_length~annual_data_clean$rideable_type+annual_data_clean$ride_hours, FUN = max)
max(mean(annual_data_clean$ride_length))

#Export Dataframe as csv file
fwrite(short_ride, file = "C:\\Users\\Dev-Environment\\Work_Space\\Tutorial\\Coursera\\Google_Data_Analytics_Specialization\\08_Capstone\\Project_01\\01_Cyclic_Trip\\Work_Flow\\Viz\\short_ride.csv")