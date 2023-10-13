# Read in data (make sure read_csv and not read.csv)

library(tidyverse)
gapminder_data <- read.csv("data/gapminder_data.csv")
gapminder_data 

# Summarize ------------------------------------------------------------------
# cmd/crtl+shift+R or go to Code > Insert Section 


summarize(gapminder_data, mean(lifeExp))
# if you add averageLifeExp = mean(lifeExp) you can make it output the value w/ a new name
summarize(gapminder_data, AverageLifeExp=mean(lifeExp))

# ctrl/cmd+shift+m for pipeline

gapminder_data %>%
  summarize(averageLifeExp=mean(lifeExp))
# lines 13 and 18 give same readout but 18 goes through pipeline

# save to object
gapminder_data_summarized <- gapminder_data %>%
  summarize(averageLifeExp=mean(lifeExp))

gapminder_data_summarized * 2

# filter for most recent year
gapminder_data %>%
  summarize(recent_year = max(year))


# get max year in filter()

gapminder_data %>%
  filter(year == 2007) %>%
  summarize(average = mean(lifeExp))

# line 36 is again the pipeline - need to have %>% for the pipeline
# the harder way without pipe
# summarize(filter(gapminder_data, year == 2007)),

# if needed you can add # to a line of code that isn't working to troubleshoot what isnt working.

# what is the earliest year int eh data set
# summarize avg GDP Per Capita for the earliest year int he data set

gapminder_data %>%
  summarize(oldest_year = min(year))

gapminder_data %>%
  filter(year == 1952) %>%
  summarize(average = mean(gdpPercap))


# Grouping----------------
# What is the mean life expectancy for each year
##### You need to have %>% for each filter pipeline

gapminder_data %>%
  group_by(year) %>%
  summarize(average = mean(lifeExp))
  
# you can add groups/filters by adding and separating by commas
gapminder_data %>%
  group_by(year, country) %>%
  summarize(average = mean(lifeExp))

# what is the mean life expectancy for each continent?

gapminder_data %>%
  group_by(continent) %>%
  summarize(average = mean(lifeExp))

# what is the mean life expectancy and mean GDP per capita for each continent
gapminder_data %>%
  group_by(continent) %>%
  summarize(
    meanLifeExp = mean(lifeExp),
    meangdpPercap = mean(gdpPercap))

#add in Max life
gapminder_data %>%
  group_by(continent) %>%
  summarize(
    meanLifeExp = mean(lifeExp),
    maxLifeExp = max(lifeExp),
    meangdpPercap = mean(gdpPercap))


# Mutate---------------------------
# mutate() allows you to manipulate data

gapminder_data %>%
  mutate(double_year = year*2)

# what is the gdp (not gdp per cap)
gapminder_data %>%
  mutate(GDP = gdpPercap*pop)


# make a new column for population in millions
gapminder_data %>%
  mutate(PopInMillions = pop/1000000)

gapminder_data %>%
  mutate(PopInMillions = pop/1000000,
  gdp = pop*gdpPercap)


# glimpse, rotates the view so it fits int eh console window better

gapminder_data %>%
  mutate(PopInMillions = pop/1000000,
         gdp = pop*gdpPercap) %>% glimpse()

gapminder_data %>%
  group_by(country) %>%
  filter(continent == "Asia") %>%
  mutate(gdp = pop * gdpPercap) %>%
  summarize(meandGDP = mean(gdp))
mysummary
view(mysummary)


# Do both in one tibble


# assign (write) to new tibble object. 

# first assign object
mysummary <- gapminder_data %>%
# then create new tibble with summary
gapminder_data %>%
  group_by(country) %>%
  filter(continent == "Asia") %>%
  mutate(gdp = pop * gdpPercap) %>%
  summarize(meandGDP = mean(gdp))
mysummary
view(mysummary)
# distinct only pulls that
gapminder_data %>%
  distinct(continent)

# Select ------------------

# select(): choose a subset of columns from a dataset

gapminder_data %>%
  select(pop,year)

# select(-) will remove a section from the data
gapminder_data %>%
  select(-continent)

# create a tibble with only country, continet, year, lifeExp
gapminder_data %>%
  select(country, continent, year, lifeExp)

# select helper function: starts_with() can filter for specific data to select

gapminder_data %>%
  select(year, starts_with("c"))

# select columns with names ending in "P" using ends_with()

gapminder_data %>%
  select(year, ends_with("p"))


# pivot_wider() makes the output wider. You want to use options that are 
# categorical and you can make new columns out of it. The ' are there bc it
# does not like to start columns with a number. Remember to use help function 
# if confused or not working

gapminder_data %>%
  select(country, continent, year, lifeExp) %>%
  pivot_wider(names_from=year, values_from=lifeExp)

# using names_prefix

gapminder_data %>%
  select(country, continent, year, lifeExp) %>%
  pivot_wider(names_from=year, values_from=lifeExp,
  names_prefix = "yr")

# creates new table
widedata <- gapminder_data %>%
  select(country, continent, year, lifeExp) %>%
  pivot_wider(names_from=year, 
              values_from=lifeExp,
              names_prefix = "yr")
view(widedata)
pivot_longer


# Joins---------------------
# match rows of 2 graphs by a common data pint or paramater
# left_join(df1, df2, by=("country"="countries")
#### make sure that the path youa re usign is the correct directory
# i.e. I had data/co2-un-data.csv but i was already in the data folder, so I
# need to remove data/

# use the c function if the names mis match, this allows you to designate that 
#they are the same if the values are different
co2_data <-read_csv("co2-un-data.csv", skip=1) %>%
  rename(countries= '...2')

joined <- left_join(gapminder_data, co2_data,
                    by = c("country" = "countries",
                           "year" = "Year"))

view(joined)          
                    