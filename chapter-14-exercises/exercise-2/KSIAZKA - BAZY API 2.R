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

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Pulp Fiction"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
base_URI <- "https://api.nytimes.com/svc/movies/v2"
resource <- "reviews/search.json"
params <- list("api-key" = nty_apikey, query = movie_name)

# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
ResGET <- GET(paste0(base_URI,resource),query = params)
print(ResGET)
# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
PulpContent <- content(ResGET, type = "text")
print(PulpContent)
Pulp <- jsonlite::fromJSON(PulpContent)
print(Pulp)
names(Pulp)
# What kind of data structure did this produce? A data frame? A list?
is.data.frame(Pulp)
is.list(Pulp)
# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
str(Pulp)
names(Pulp)
Results <- Pulp$results
Results$link.url
Results$link$url
# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(Results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
Recent <- reviews[max(reviews$publication_date) == reviews$publication_date,]
Headline <- Recent$headline
ShortSum <- Recent$summary_short
Link <- Recent$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
ListaDanych <- list("Headline" = Headline, "Short Summary" = ShortSum, "Link" = Link)
