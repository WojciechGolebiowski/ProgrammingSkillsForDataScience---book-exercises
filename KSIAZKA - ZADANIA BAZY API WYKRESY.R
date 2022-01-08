# ROZDZIAL 13 - CZESC 1 ---------------------------------------------------

# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
install.packages(c("DBI","RSQLite"))
install.packages("dbplyr")
library(DBI)
library(RSQLite)
library(dplyr)
# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
getwd()
Chinook_Sqlite <- DBI::dbConnect(SQLite(),"book-exercises/chapter-13-exercises/exercise-1/data/Chinook_Sqlite.sqlite")

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
dbListTables(Chinook_Sqlite)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
genres <- tbl(Chinook_Sqlite,"Genre")
print(genres)
# Try to use `View()` to see the contents of the table. What happened?
View(genres) #WYSWIETLA LISTE ZAMIAST TABELI

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
genres <- collect(genres)
View(genres)
# Use dplyr's `count()` function to see how many rows are in the genre table
count(genres)

# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
track <- tbl(Chinook_Sqlite,"Track")
track <- collect(track)
# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filting for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!
track %>% filter(!(is.na(Composer))) %>% group_by(Composer) %>% summarise(count = n()) %>% arrange(-count)

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
#BEZ TEGO COLLECTA() WYWALALO BLAD Z PRZETWARZANIEM JOINA
GenresID <- track %>% filter(!(is.na(GenreId))) %>% group_by(GenreId) %>% summarise(count = n()) %>% collect() %>% 
  left_join(genres, by = c("GenreId" = "GenreId")) %>% arrange(-count)

# Bonus: Query for a list of the most popular artist for each genre in the
# library (a "representative" artist for each).
# Consider using multiple grouping operations. Note that you can only filter
# for a `max()` value if you've collected the data into memory.
Popularity <- track %>% filter(!(is.na(Composer)|is.na(GenreId))) %>%  group_by(GenreId,Composer) %>% 
  summarise(count = n()) %>% filter(count == max(count)) %>% collect()

track %>% filter(GenreId == 25)
# Remember to disconnect from the database once you are done with it!
dbDisconnect(Chinook_Sqlite)


# ROZDZIA£ 14- CZESC 1 ----------------------------------------------------

# Exercise 1: reading and querying a web API

# Load the httr and jsonlite libraries for accessing data
# You can also load `dplyr` if you wish to use it
install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)
library(dplyr)

# Create a variable base_uri that stores the base URI (as a string) for the 
# Github API (https://api.github.com)
base_uri <- "https://api.github.com"

# Under the "Repositories" category of the API documentation, find the endpoint 
# that will list _repos in an organization_. Then create a variable named
# `org_resource` that stores the endpoint for the `programming-for-data-science`
# organization repos (this is the _path_ to the resource of interest).
org_resource <- "/orgs/programming-for-data-science/repos"

# Send a GET request to this endpoint (the `base_uri` followed by the 
# `org_resource` path). Print the response to show that your request worked. 
# (The listed URI will also allow you to inspect the JSON in the browser easily).
GetTest <- httr::GET(paste0(base_uri,org_resource))
print(GetTest)
# Extract the content of the response using the `content()` function, saving it
# in a variable.
response <- content(GetTest,type = "text")

# Convert the content variable from a JSON string into a data frame.
res_data <- fromJSON(response)

# How many (public) repositories does the organization have?
colnames(res_data)
res_data %>% filter(private == FALSE) %>% nrow()

# Now a second query:
# Create a variable `search_endpoint` that stores the endpoint used to search 
# for repositories. (Hint: look for a "Search" endpoint in the documentation).
search_endpoint <- "/search/repositories"

# Search queries require a query parameter (for what to search for). Create a 
# `query_params` list variable that specifies an appropriate key and value for 
# the search term (you can search for anything you want!)
query_params <- list(q = "NBA")

# Send a GET request to the `search_endpoint`--including your params list as the
# `query`. Print the response to show that your request worked.
NBArepos <- GET(url = paste0(base_uri,search_endpoint),query = query_params)
print(NBArepos)
# Extract the content of the response and convert it from a JSON string into a
# data frame. 
NBA <- content(NBArepos,type = "text")
NBAtab <- fromJSON(NBA)

# How many search repos did your search find? (Hint: check the list names to 
# find an appropriate value).
is.data.frame(NBAtab)
str(NBAtab)
names(NBAtab)
NBAitems <- NBAtab$items

# What are the full names of the top 5 repos in the search results?
NBAitems$full_name[1:5]


# ROZDZIA£ 14 - CZESC 2 ---------------------------------------------------

# Exercise 2: working with data APIs

# load relevant libraries
library("httr")
library("jsonlite")

#RESZTA W FOLDERZE Z ZADANIEM


# ROZDZIA£ 16 - CZESC 1 ---------------------------------------------------

# Exercise 1: ggplot2 basics

# Install and load the `ggplot2` package
# You will also want to load `dplyr`
library(ggplot2)
library(dplyr)
# For this exercise you'll be working with the `diamonds` data set included in 
# the ggplot2 library
# Use `?diamonds` to get more information about this data set (including the 
# column descriptions. Also check the _column names_ and the _number of rows_ 
# in the data set
?diamonds
colnames(diamonds)
nrow(diamonds)
# This data set has A LOT of rows. To make things a bit more readable, 
# use dplyr's `sample_n()` function to get a random 1000 rows from the data set
# Store this sample in a variable `diamonds_sample`
diamonds_sample <- diamonds %>% sample_n(1000)

# Start by making a new `ggplot` with the `diamonds_sample` as the data (no 
# geometry yet)
# What do you see? (What did you expect?)
ggplot(diamonds_sample) #blank canva - nothing in there actually

# Draw a scatter plot (with point geometry) with for the `diamonds_sample` set, 
# with the `carat` mapped to the x-position and `price` mapped to the y-position.
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price))

# Draw the same plot as above, but color each of the points based on their 
# clarity.
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, color = clarity))

# Draw the same plot as above, but for the entire `diamonds` data set. Note this
# may take a few seconds to generate.
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price, color = clarity))

# Draw another scatter plot for `diamonds_sample` of price (y) by carat (x),
# but with all of the dots colored "blue".
# Hint: you'll need to set the color channel, not map a value to it!
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price), color = "blue")

# Draw a scatter plot for `diamonds_sample` of `price` by `carat`, where each
# point has an aesthetic _shape_ based on the diamond's `cut`.
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, shape = cut), color = "blue")

# Draw a scatter plot for `diamonds_sample` of *`cut`* by `carat`, where each
# point has an aesthetic _size_ based on the diamond's *`price`*
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, size = price), color = "blue")

# Try coloring the above plot based on the diamond's price!
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, size = price, color = price))

# Draw a line plot (with line geometry) for `diamonds_sample`. The x-position 
# should be mapped to carat, y-position to price, and color to cut.
ggplot(diamonds_sample) +
  geom_line(aes(x = carat, y = price, color = cut))

# That's kind of messy. Try using `smooth` geometry instead.
ggplot(diamonds_sample) +
  geom_smooth(aes(x = carat, y = price, color = cut))

# Draw a plot with column geometry (a bar chart), mapping the diamond's `cut` to 
# the x-axis and `price` to the y-axis. Note that by default, column geometry 
# will us the "sum" of all of the y-values, so that the chart is actually of the
# TOTAL value of all of the diamonds of that cut!
ggplot(diamonds_sample) +
  geom_col(aes(x = cut, y = price))

# Add an aesthetic property that will _fill_ each bar geometry based on the 
# `clarity` of the diamonds. 
# What kind of chart do you get?
ggplot(diamonds_sample) +
  geom_col(aes(x = cut, y = price, fill = clarity))


# Draw a plot of the `diamonds_sample` data (price by carat), with both points 
# for each diamond AND smoothed lines for each cut (hint: in a separate color)
# Give the points an `alpha` (transparency) of 0.3 to make the plot look nicer
ggplot(diamonds_sample, aes(x =  price, y = carat)) +
  geom_point(alpha = 0.3) +
  geom_smooth(aes(color = cut))

## Bonus
# Draw a column chart of average diamond prices by clarity, and include 
# "error bars" marking the standard error of each measurement.
#
# You can calculate standard error as the _standard deviation_ divided by the 
# square root of the number of measurements (prices)
# Start by creating a data frame `clarity_summary` that includes summarized data 
# for each clarity group. Your summary data should include the mean price and the
# standard error of the price
# Then draw the plot. The error bars should stretch from the mean-error to the 
# mean+error.
summary_diamond <- diamonds %>% group_by(clarity) %>% summarise(average_price = mean(price), 
                                                                error = sd(price)/sqrt(n()))
ggplot(summary_diamond, aes(x = clarity, y = average_price)) +
  geom_col() +
  geom_errorbar(aes(ymin = average_price - error, ymax = average_price + error))
#BLAD STANDARDOWY TO ODCH.STANDARDOWE/SQRT(LICZBA OBSERWACJI)

# ROZDZIA£ 16 - CZESC 2 ---------------------------------------------------

# Exercise 2: advanced ggplot2 practice

# Install and load the `ggplot2` package
#install.packages('ggplot2')
library("ggplot2")

# For this exercise you will again be working with the `diamonds` data set.
# Use `?diamonds` to review details about this data set
?diamonds

## Position Adjustments

# Draw a column (bar) chart of diamonds cuts by price, with each bar filled by 
# clarity. You should see a _stacked_ bar chart.
ggplot(diamonds) +
  geom_col(aes(x = cut, y = price, fill = clarity))

# Draw the same chart again, but with each element positioned to "fill" the y axis
ggplot(diamonds) +
  geom_col(aes(x = cut, y = price, fill = clarity),position = "fill")

# Draw the same chart again, but with each element positioned to "dodge" each other
ggplot(diamonds) +
  geom_col(aes(x = cut, y = price, fill = clarity),position = "dodge")

# Draw a plot with point geometry with the x-position mapped to `cut` and the 
# y-position mapped to `clarity`
# This creates a "grid" grouping the points
ggplot(diamonds) + geom_point(aes(x = cut, y = clarity))

# Use the "jitter" position adjustment to keep the points from all overlapping!
# (This works a little better with a sample of diamond data, such as from the 
# previous exercise).
ggplot(diamonds_sample) + geom_point(aes(x = cut, y = clarity), position = "jitter")
#jitter wyrzuca czesc obserwacji poza dany punkt tak zeby na siebie nie nachodzily - takie rozmycie
#Jitter - drganie,drgaæ

## Scales

# Draw a "boxplot" (with `geom_boxplot`) for the diamond's price (y) by color (x)
ggplot(diamonds) + geom_boxplot(aes(x = color, y = price))

# This has a lot of outliers, making it harder to read. To fix this, draw the 
# same plot but with a _logarithmic_ scale for the y axis.
ggplot(diamonds) + geom_boxplot(aes(x = color, y = price)) + scale_y_log10()

# For another version, draw the same plot but with `violin` geometry instead of 
# `boxplot` geometry!
# How does the logarithmic scale change the data presentation?
ggplot(diamonds) +
  geom_violin(aes(x = color, y = price))

# Another interesting plot: draw a plot of the diamonds price (y) by carat (x), 
# using a heatmap of 2d bins (geom_bin2d)
# What happens when you make the x and y channels scale logarithmically?
ggplot(diamonds_sample) +
  geom_bin2d(aes(x = carat, y = price))+
  scale_x_log10() + 
  scale_y_log10()

# Draw a scatter plot for the diamonds price (y) by carat (x). Color each point
# by the clarity (Remember, this will take a while. Use a sample of the diamonds 
# for faster results)
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, color = clarity))

# Change the color of the previous plot using a ColorBrewer scale of your choice. 
# What looks nice?
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, color = clarity)) +
  scale_color_brewer(palette = "Set3")


## Coordinate Systems

# Draw a bar chart with x-position and fill color BOTH mapped to cut
# For best results, SET the `width` of the geometry to be 1 (fill plot, no space
# between)
# TIP: You can save the plot to a variable for easier modifications
ColPlot <- ggplot(diamonds_sample) +
  geom_col(aes(x = cut, y = price, color = cut), width = 1)

# Draw the same chart, but with the coordinate system flipped
ColPlot + coord_flip()

# Draw the same chart, but in a polar coordinate system. It's a Coxcomb chart!
ColPlot + coord_polar()


## Facets

# Take the scatter plot of price by carat data (colored by clarity) and add 
# _facets_ based on the diamond's `color`
ggplot(diamonds_sample) +
  geom_point(aes(x = carat, y = price, color = clarity)) +
  facet_wrap(~color)


## Saving Plots!!!!!!!!!!!!!!!!!!!!!!1

# Use the `ggsave()` function to save the current (recent) plot to disk.
# Name the output file "my-plot.png".
# Make sure you've set the working directory!!
ggsave("my_plot.png")


# ROZDZIA£ 17 - CZESC 1 ---------------------------------------------------

# Exercise 1: Creating a grouped bar chart of cancer rates in King County, WA
# (using plotly)

# Load necessary packages (`dplyr`, `ggplot2`, and `plotly`)
library(dplyr)
library(ggplot2)
library(plotly)
# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location

# Load the `"data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv` file
# into a variable `mortality_rates`
# Make sure strings are *not* read in as factors
mortality_rate <- read.csv("C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-17-exercises/exercise-1/data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv",stringsAsFactors = FALSE)

# This is actually a very large and rich dataset, but we will only focus on
# a small subset of it. Create a new data frame `plot_data` by filtering the
# `mortality_rates` data to the following:
# - The `location_name` is "King County"
# - The `sex` is *not* "Both"
# - The `cause_name` is "Neoplasms"
# - The `year_id` is greater than 2004
# - Only keep the columns `sex`, `year_id`, and `mortality_rate`

mortality_rate <- mortality_rate %>% 
  filter(location_name == "King County",
         sex != "Both",
         cause_name == "Neoplasms",
         year_id > 2004) %>% 
  select(sex, year_id, mortality_rate)
# Using ggplot2 (recall chapter 16), make a grouped ("dodge") bar chart of
# mortality rates each year, with different bars for each sex.
# Store this plot in a variable `mort_plot`
mort_plot <- ggplot(mortality_rate) +
  geom_col(aes(x = year_id, y = mortality_rate, fill = sex), position = "dodge")
  

# To make this plot interactive, pass `mort_plot` to the `ggplotly()` function
# (which is part of the `plotly` package). This will make your plot interactive!
ggplotly(mort_plot)

# As an alternative to making a ggplot chart interactive, we can build the same
# plot using the plotly API directly

# Using the `plot_ly()` function from the `plotly` package, pass in `plot_data`
# as the data, and specify `year_id` as the x variable, mortality_rate as
# the y variable, and `sex` as the color variable. 
# (make sure to specify these as *formulas*)
# Also set the plot type to "bar". Store the result in a variable.
Dane <- plot_ly(data = mortality_rate,
        x= ~year_id,
        y = ~mortality_rate,
        color = ~sex,
        type = "bar")


# You should see that the cancer mortaility rates for female and males 
# each year are plotted next to each other.
# Now that we have the foundation down, we can make our plot more presentable
# by adding a layout to the plot. Add a title for the overall plot, and
# a title for each axes.
Dane %>% layout(title = "Mortality Rate by sex - Neoplasms", xaxis = list(title = "Year"), yaxis = list(title = "Mortality Rate"))


# ROZDZIA£ 17 - CZÊŒÆ 2 ---------------------------------------------------

# Exercise 2: Creating a grouped bar chart of cancer rates in King County, WA
# (using rbokeh)

# Load necessary packages (`dplyr`, `ggplot2`, and `rbokeh`)
library(rbokeh)

# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location

# Load the `"data/IHME_WASHINGTON_MORTALITY_RATES_1980_2014.csv` file
# into a variable `mortality_rates`
# Make sure strings are *not* read in as factors



# This is actually a very large and rich dataset, but we will only focus on
# a small subset of it. Create a new data frame `plot_data` by filtering the
# `mortality_rates` data to the following:
# - The `location_name` is "King County"
# - The `sex` is *not* "Both"
# - The `cause_name` is "Neoplasms"
# - The `year_id` is greater than 2004
# - Only keep the columns `sex`, `year_id`, and `mortality_rate`
mortality_rate

# Creating a plot with rbokeh requires a few steps:

# Initialize your chart using the `figure()` function, specifying:
# - The `data`  to plot (e.g., `plot_data`), and
# - The `title` (e.g., "Neoplasms Mortality Rate in King County")
# Store this in a variable `p`
p <- figure(mortality_rate, title = "Mortality by sex - Neoplasms")

# Then, add a layer of bars (via a pipe %>%) specifying your data encodings. 
# You will use the `ly_bar()` function to do this, which (oddly) requires that 
# the `x` variable is specified as a string (i.e., as.character(year_id)). Set:
# - The `x` variable as the `year_id` (as a *character*)
# - The `y` variable as the `mortality_rate`
# - The `color` varaible as the `sex`
# - The `position` as "dodge" (as opposed to stacked)
p %>% ly_bar(x = as.character(year_id),
             y = mortality_rate,
             color = sex,
             position = "dodge") %>% 

# Finally, you can add better axis labels (again, via a pipe %>%) by passing 
# your plot `p` to the `x_axis()` and `y_axis()` functions.
      x_axis(label = "year") %>% 
      y_axis(label = "mortality rate")


# ROZDZIAL 17 - CZÊŒÆ 3 ---------------------------------------------------

# Exercise 3: Mapping U.S. city populations
# (using leaflet)

# Load necessary packages (`dplyr` and `leaflet`)
library(leaflet)

# Load the `"data/uscitiesv1.4.csv` file into a variable `populations`
# Make sure strings are *not* read in as factors
populations <- read.csv("C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-17-exercises/exercise-3/data/uscitiesv1.4.csv",stringsAsFactors = FALSE)

# Because leaflet can only render a few thousand points, create a variable
# `most_populous` that has the 1000 cities with the largest populations
# (hint: use `top_n()`)
populations <- populations %>% arrange(-population) %>%  top_n(1000)

# To create a base layer map (that has access to your data), create a variable
# `map` by passing your `most_populous` data to the `leaflet()` function and
# then adding a layer of map tiles (via a pipe %>% ) by calling the 
# `add_tiles()` function. This will create a blank map.
map <- leaflet(populations) %>% 
  addTiles()

# To add a layer of circles to your map, pipe your `map` variable to the 
# `addCircleMarkers` function, specifying the following:
# - The latitude (`lat`) as the variable `lat` (as a formula)
# - The longitude (`lng`) as the variable `lng` (as a formula)
# - The pop-up text (`popup`) as the variable `city` (as a formula)
# - The outline of each circle (`stroke`) should be `FALSE`
# - The `radius` should be 1, and the `fillOpacity` should be .5
map %>% addCircles(lng = ~lng,lat = ~lat, popup = ~city, stroke = TRUE, label = ~city, fillOpacity = 0.5, radius = 5)

# If you want each city to be sized proportionally to the population, 
# you have to compute the desired number of pixels for each marker. Create a 
# new column `radius` that is the population relative to the maximum population
# times a constant number of pixels (e.g., 3). If you want the *area* to be
# proportional to the data, you should *square* this value.
populations$radius <- 50000*populations$density/max(populations$density)

# Remake the map from above, specifying the `radius` column as the radius
leaflet(populations) %>% 
  addTiles() %>% addCircles(lng = ~lng,
                            lat = ~lat, 
                            popup = ~city,
                            stroke = TRUE, 
                            label = ~city, 
                            fillOpacity = 0.5, 
                            radius = ~radius)




