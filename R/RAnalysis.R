#tidyr package
library(tidyr)
table4a

#make data longer by row
long = table4a %>% pivot_longer(names_to = 'years', values_to = 'cases', -country)
print(long)

#make data longer by column
back2wide = long %>% pivot_wider(names_from = 'years', values_from = 'cases')
print(back2wide)

#separate by "/"
table3
table3 %>%
  separate(rate, sep = "/",into = c("cases", "population"))

table3 %>%
  separate(rate, sep = "/",into = c("cases", "population"), remove = FALSE)
 
table5

table5 %>%
  unite(new, century, year, sep = "")

#fill na with before data
score = tribble(
  ~ person, ~ Math, ~ Computer,
  "Henry",  1,         7,
  NA,       2,         10,
  NA,       NA,        9,
  "David",  1,         4)

score

score %>%
  fill(person, Math)

score %>% replace_na(replace = list(person = "unknown", Math = 0))


#dplyr package
library(dplyr)
library(nycflights13)
flights

#use select function to select column
date = flights %>% select(year, month, day)
flights %>% select(year:day)
flights %>% select(-(year:day))
dep = flights %>% select(starts_with("dep"))
flights %>% select(ends_with("time"))
flights %>% select(contains("time"))

#filter
flights %>% filter(month == 3, day == 1)
flights %>% filter(dep_time>100)

#summarize
#if NA exists cannot use summarize function
flights %>% summarize(max_dep = max(dep_time, na.rm = TRUE),
                      min_dep = min(dep_time, na.rm = TRUE))

#group_by
by_day = flights %>% group_by(year, month, day)

by_day

by_day %>%  summarise(delay = mean(dep_delay, na.rm = TRUE))

flights %>% group_by(dest) %>%  summarize(
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)

#arrange
flights %>% arrange(year, month, day)

flights %>% arrange(desc(dep_delay))


#join
flights2 = flights %>%
  select(year:day, hour, tailnum, carrier)

flights2 #carrier is simply named

airlines #full name

flights2 %>%  left_join(airlines, by = "carrier")


flights_sml = flights %>%  select(
  year:day,
  ends_with("delay"),
  distance,
  air_time
)

#mutate
flights_sml %>%  mutate(
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60) 


flights_sml %>%  mutate(
  across(c('dep_delay', 'arr_delay'), ~ .x * 60)
) 

flights_sml %>%  mutate(
  across(contains('delay'), ~ .x * 60)
) 

flights_sml %>%  mutate(
  across(where(is.numeric), ~ .x * 60)
)

