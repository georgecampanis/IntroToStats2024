#######################################################
## DATA WRANGLING
# dplyr
## https://moderndive.com/3-wrangling.html#wrangling-packages
library(nycflights13)
library(dplyr)



diamonds %>%
  group_by(cut) %>%
  summarize(avg_price = mean(price))
####################
#    filter
###################

alaska_flights <- flights %>% 
  filter(carrier == "AS")


portland_flights <- flights %>% 
  filter(dest == "PDX")
View(portland_flights)


btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK" & (dest == "BTV" | dest == "SEA") & month >= 10)
# & |


#COMMA works too
# filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10) 


# %IN%
#filter(dest %in% c("SEA", "SFO", "PDX", "BTV", "BDL"))

####################
#    summarize
###################
# dealing with NA
summary_temp <- weather %>% 
  summarize(mean = mean(temp), std_dev = sd(temp))
summary_temp


glimpse(weather)


summary_temp <- weather %>% 
  summarize(mean = mean(temp, na.rm = TRUE), # na.rm
            std_dev = sd(temp, na.rm = TRUE))
summary_temp

# mean(): the average
# sd(): the standard deviation, which is a measure of spread
# min() and max(): the minimum and maximum values, respectively
# IQR(): interquartile range
# sum(): the total amount when adding multiple numbers
# n(): a count of the number of rows in each group.

####################
#    group by
###################

summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
summary_monthly_temp



library(ggplot2)
diamonds

diamonds %>% 
  group_by(cut) # nothing changed but we see 5 possible cut groups

diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price))


by_origin <- flights %>% 
  group_by(origin) %>% 
  summarize(count = n())# note n() 
by_origin

# group by more than 1 val
by_origin_monthly <- flights %>% 
  group_by(origin, month) %>% # NOTE; comma!
  summarize(count = n())
by_origin_monthly


####################
#    mutate
###################
# make var

weather <- weather %>% # note: var overwrite
  mutate(temp_in_C = (temp - 32) / 1.8)# create new var

glimpse(weather)

summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean_temp_in_F2 = mean(temp, na.rm = TRUE), 
            mean_temp_in_C2 = mean(temp_in_C, na.rm = TRUE))
summary_monthly_temp




flights <- flights %>% 
  mutate(gain = dep_delay - arr_delay)


gain_summary <- flights %>% 
  summarize(
    min = min(gain, na.rm = TRUE),
    q1 = quantile(gain, 0.25, na.rm = TRUE),
    median = quantile(gain, 0.5, na.rm = TRUE),
    q3 = quantile(gain, 0.75, na.rm = TRUE),
    max = max(gain, na.rm = TRUE),
    mean = mean(gain, na.rm = TRUE),
    sd = sd(gain, na.rm = TRUE),
    missing = sum(is.na(gain))# note: missing vals
    
  )
gain_summary

ggplot(data = flights, mapping = aes(x = gain)) +
  geom_histogram(color = "white", bins = 20)

# create multiple vars
flights <- flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
  )

####################
#    arrange and sort rows
###################
freq_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n())
freq_dest


freq_dest %>% 
  arrange(num_flights)

freq_dest %>% 
  arrange(desc(num_flights))# note: desc

####################
#    Joins
###################
flights_joined <- flights %>% 
  inner_join(airlines, by = "carrier") #Note: joined on carrier
View(airlines)
View(flights)
View(flights_joined)

#left_join(), right_join(), outer_join(), and anti_join()

# what about different keys?
flights_with_airport_names <- flights %>% 
  inner_join(airports, by = c("dest" = "faa"))
View(flights_with_airport_names)

View(airports)


named_dests <- flights %>%
  group_by(dest) %>%
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  rename(airport_name = name)
named_dests



flights_weather_joined <- flights %>%
  inner_join(weather, by = c("year", "month", "day", "hour", "origin"))
View(flights_weather_joined)


p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar)
