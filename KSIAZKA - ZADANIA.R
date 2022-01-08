
# ROZDZIAÅ 5 --------------------------------------------------------------

# Exercise 1: practice with basic R syntax

# Create a variable `hometown` that stores the city in which you were born
hometown <- 'Wroclaw'

# Assign your name to the variable `my_name`
my_name <- 'Wojtek'

# Assign your height (in inches) to a variable `my_height`
my_height <- 188

# Create a variable `puppies` equal to the number of puppies you'd like to have
puppies <- 1

# Create a variable `puppy_price`, which is how much you think a puppy costs
puppy_price <- 102

# Create a variable `total_cost` that has the total cost of all of your puppies
total_cost <- puppies * puppy_price

# Create a boolean variable `too_expensive`, set to TRUE if the cost is greater 
# than $1,000
too_expensive <- total_cost > 1000

# Create a variable `max_puppies`, which is the number of puppies you can 
# afford for $1,000
max_puppies <- floor(1000/total_cost)


# ROZDZIAÅ 6 - CZESC 1 ----------------------------------------------------

# Exercise 1: calling built-in functions

# Create a variable `my_name` that contains your name
my_name

# Create a variable `name_length` that holds how many letters (including spaces)
# are in your name (use the `nchar()` function)
name_length <- nchar(my_name)

# Print the number of letters in your name
name_length

# Create a variable `now_doing` that is your name followed by "is programming!" 
# (use the `paste()` function)
now_doing <- paste(my_name, "is programming")

# Make the `now_doing` variable upper case
now_doing <- toupper(now_doing)

### Bonus

# Pick two of your favorite numbers (between 1 and 100) and assign them to 
# variables `fav_1` and `fav_2`
fav_1 <- 23
fav_2 <- 10
# Divide each number by the square root of 201 and save the new value in the
# original variable
fav_1 <- fav_1/sqrt(201)
fav_2 <- fav_2/sqrt(201)
# Create a variable `raw_sum` that is the sum of the two variables. Use the 
# `sum()` function for practice.
raw_sum <- sum(fav_1,fav_2)

# Create a variable `round_sum` that is the `raw_sum` rounded to 1 decimal place.
# Use the `round()` function.
round_sum <- round(raw_sum,digits = 1)

# Create two new variables `round_1` and `round_2` that are your `fav_1` and 
# `fav_2` variables rounded to 1 decimal places
round1 <- round(fav_1,digits = 1)
round2 <- round(fav_2,digits=1)
# Create a variable `sum_round` that is the sum of the rounded values
sum_round <- sum(round1,round2)

# Which is bigger, `round_sum` or `sum_round`? (You can use the `max()` function!)
max(sum_round,round_sum)


# ROZDZIAÅ 6 - CZESC 2 ----------------------------------------------------

# Exercise 2: using built-in string functions

# Create a variable `lyric` that contains the text "I like to eat apples and 
# bananas"
lyric <- "I like to eat apples and bananas"

# Use the `substr()` function to extract the 1st through 13th letters from the 
# `lyric`, and store the result in a variable called `intro`
# Use `?substr` to see more about this function
intro <- substr(lyric,1,13)

# Use the `substr()` function to extract the 15th through the last letter of the 
# `lyric`, and store the result in a variable called `fruits`
# Hint: use `nchar()` to determine how many total letters there are!
fruits <- substr(lyric,15,nchar(lyric))

# Use the `gsub()` function to substitute all the "a"s in `fruits` with "ee".
# Store the result in a variable called `fruits_e`
# Hint: see http://www.endmemo.com/program/R/sub.php for a simpmle example (or 
# use `?gsub`)
fruits_e <- gsub("a","ee",fruits)

# Use the `gsub()` function to substitute all the "a"s in `fruits` with "o".
# Store the result in a variable called `fruits_o`
fruits_o <- gsub("a","o",fruits)

# Create a new variable `lyric_e` that is the `intro` combined with the new
# `fruits_e` ending. Print out this variable
lyric_e <- paste(intro,fruits_e)
lyric_e
# Without making a new variable, print out the `intro` combined with the new
# `fruits_o` ending
print(paste(intro,fruits_o))


# ROZDZIAÅ 6 - CZESC 3 ----------------------------------------------------

# Exercise 3: writing and executing functions

# Define a function `add_three` that takes a single argument and
# returns a value 3 greater than the input

add_three <- function(num){
  num + 3
}

add_three(3)

# Create a variable `ten` that is the result of passing 7 to your `add_three` 
# function
ten <- add_three(7)

# Define a function `imperial_to_metric` that takes in two arguments: a number 
# of feet and a number of inches
# The function should return the equivalent length in meters
imperial_to_metric <- function(feet_num,inches){
  feet_num*(inches*0.0254)
}
imperial_to_metric(46,12)


# ROZDZIAÅ 6 - CZESC 4 ----------------------------------------------------

# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function(str1,str2){
  nchar(str2)*2 <= nchar(str1) | nchar(str1)*2 <= nchar(str2)
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_as_long("razra","dwa")


# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(str,str2){
  if(nchar(str)>nchar(str2)){
    paste("Your first string is longer by", nchar(str)-nchar(str2) ,"character/s")
  } else if (nchar(str2)>nchar(str)){
    paste("Your second string is longer by", nchar(str2)-nchar(str) ,"character/s")
  } else {
    paste("Your strings are the same length!")
  }
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
describe_difference("raza","dwaaaadasfsafaf")



# ROZDZIAL 7 - CZESC 1 ----------------------------------------------------

# Exercise 1: creating and operating on vectors

# Create a vector `names` that contains your name and the names of 2 people 
# next to you. Print the vector.
names <- c("Woj","Daro","Kubica")
print(names)
# Use the colon operator : to create a vector `n` of numbers from 10:49
n <- 10:49

# Use the `length()` function to get the number of elements in `n`
length(n)

# Add 1 to each element in `n` and print the result
print(n + 1)

# Create a vector `m` that contains the numbers 10 to 1 (in that order). 
# Hint: use the `seq()` function
m <- 10:1

# Subtract `m` FROM `n`. Note the recycling!
n-m

# Use the `seq()` function to produce a range of numbers from -5 to 10 in `0.1`
# increments. Store it in a variable `x_range`
x_range <- seq(-5,10,0.1)

# Create a vector `sin_wave` by calling the `sin()` function on each element 
# in `x_range`.
sin_wave <- sin(x_range)

# Create a vector `cos_wave` by calling the `cos()` function on each element 
# in `x_range`.
cos_wave <- cos(x_range)

# Create a vector `wave` by multiplying `sin_wave` and `cos_wave` together, then
# adding `sin_wave` to the product
wave <- sin_wave * cos_wave + sin_wave

# Use the `plot()` function to plot your `wave`!
plot(wave)


# ROZDZIAL 7 - CZESC 2 ----------------------------------------------------

# Exercise 2: indexing and filtering vectors

# Create a vector `first_ten` that has the values 10 through 20 in it (using 
# the : operator)

first_ten <- 10:20
# Create a vector `next_ten` that has the values 21 through 30 in it (using the 
# seq() function)
next_te <- 21:30

# Create a vector `all_numbers` by combining the previous two vectors
all_numbers <- c(first_ten,next_te)

# Create a variable `eleventh` that contains the 11th element in `all_numbers`
eleventh <- all_numbers[11]

# Create a vector `some_numbers` that contains the 2nd through the 5th elements 
# of `all_numbers`
some_numbers <- all_numbers[2:5]

# Create a vector `even` that holds the even numbers from 1 to 100
even <- c(1:100)[c(1:100)%%2 == 0]

# Using the `all()` function and `%%` (modulo) operator, confirm that all of the
# numbers in your `even` vector are even
all(even %% 2 == 0)


# Create a vector `phone_numbers` that contains the numbers 8, 6, 7, 5, 3, 0, 9
phone_numbers <- c(8,6,7,5,3,0,9)

# Create a vector `prefix` that has the first three elements of `phone_numbers`
prefix <- phone_numbers[1:3]

# Create a vector `small` that has the values of `phone_numbers` that are 
# less than or equal to 5
small <- phone_numbers[phone_numbers <= 5]

# Create a vector `large` that has the values of `phone_numbers` that are 
# strictly greater than 5
large <- phone_numbers[phone_numbers > 5]

# Replace the values in `phone_numbers` that are larger than 5 with the number 5
phone_numbers[phone_numbers %in% large] <- 5

# Replace every odd-numbered value in `phone_numbers` with the number 0
phone_numbers[phone_numbers %% 2 == 1] <- 0


# ROZDZIAL 7 - CZESC 3 ----------------------------------------------------

# Exercise 3: vector practice

# Create a vector `words` of 6 (or more) words.
# You can Google for a "random word generator" if you wish!
words <- c("aa","ba","ca","da","ea","fa","gA")

# Create a vector `words_of_the_day` that is your `words` vector with the string
# "is the word of the day!" pasted on to the end.
# BONUS: Surround the word in quotes (e.g., `'data' is the word of the day!`)
# Note that the results are more obviously correct with single quotes.
words_of_the_day <- paste("'", words, "'", "is the word of the day!")

# Create a vector `a_f_words` which are the elements in `words` that start with 
# "a" through "f"
# Hint: use a comparison operator to see if the word comes before "f" alphabetically!
# Tip: make sure all the words are lower-case, and only consider the first letter
# of the word!
a_f_words <- words[substr(tolower(words),1,1) <= "f"]

# Create a vector `g_m_words` which are the elements in `words` that start with 
# "g" through "m"
g_m_words <- words[substr(tolower(words),1,1) >= "g"]

# Define a function `word_bin` that takes in three arguments: a vector of words, 
# and two letters. The function should return a vector of words that go between 
# those letters alphabetically.
word_bin <- function(words_vector,letter1,letter2){
  if(letter1 <= letter2){
    words <- words_vector[substr(tolower(words_vector),1,1) >= letter1 & substr(tolower(words_vector),1,1) <= letter2]
  } else {
    words <- words_vector[substr(tolower(words_vector),1,1) >= letter2 & substr(tolower(words_vector),1,1) <= letter1]
  }
  words
}

# Use your `word_bin` function to determine which of your words start with "e" 
# through "q"
word_bin(words,"q","e")


# ROZDZIAL 8 - CZESC 1 ----------------------------------------------------

# Exercise 1: creating and accessing lists

# Create a vector `my_breakfast` of everything you ate for breakfast
my_break <- c("jajo","mleko","banan")

# Create a vector `my_lunch` of everything you ate (or will eat) for lunch
my_lunch <- c("makaron","kawa")

# Create a list `meals` that has contains your breakfast and lunch
meals <- list(my_break = my_break,my_lunch = my_lunch)

# Add a "dinner" element to your `meals` list that has what you plan to eat 
# for dinner
meals$my_dinner <- c("jajo","ryba")

# Use dollar notation to extract your `dinner` element from your list
# and save it in a vector called 'dinner'
dinner <- c(meals$my_dinner)
dinner2 <- meals$my_dinner
# Use double-bracket notation to extract your `lunch` element from your list
# and save it in your list as the element at index 5 (no reason beyond practice)
meals[[5]] <- meals[["my_lunch"]]

# Use single-bracket notation to extract your breakfast and lunch from your list
# and save them to a list called `early_meals`
early_meals <- list(meals[c("my_lunch","my_break")])


### Challenge ###

# Create a list that has the number of items you ate for each meal
# Hint: use the `lappy()` function to apply the `length()` function to each item
number <- list(lapply(meals,length))

# Write a function `add_pizza` that adds pizza to a given meal vector, and
# returns the pizza-fied vector
add_pizza <- function(item){
  paste(item, "& pizza")
}

# Create a vector `better_meals` that is all your meals, but with pizza!
better_meals <- sapply(meals,add_pizza)
as.vector(better_meals)


# ROZDZIAL 8 - CZESC 2 ----------------------------------------------------
library(dplyr)
# Exercise 2: using `*apply()` functions

# Create a *list* of 10 random numbers. Use the `runif()` function to make a 
# vector of random numbers, then use `as.list()` to convert that to a list
rando <- runif(10) %>% as.list()

# Use `lapply()` to apply the `round()` function to each number, rounding it to 
# the nearest 0.1 (one decimal place)
lapply(rando,round,digits = 1)

# Create a variable 'sentence' that contains a sentence of text (something 
# longish). Make the sentence lowercase; you can use a function to help.
sentence <- "Puedes encontrarme una foto?"

# Use the `strsplit()` function to split the sentence into a vector of letters.
# Hint: split on `""` to split every character
# Note: this will return a _list_ with 1 element (which is the vector of letters)
SenSplit <- strsplit(sentence,"")

# Extract the vector of letters from the resulting list
SenSplit[[1]]

# Use the `unique()` function to get a vector of unique letters
UniqLett <- unique(SenSplit[[1]])

# Define a function `count_occurrences` that takes in two parameters: a letter 
# and a vector of letters. The function should return how many times that letter
# occurs in the provided vector.
# Hint: use a filter operation!
count_occurences <- function(letter,vector_letters){
  vector_letters[toupper(vector_letters) == toupper(letter)] %>% length() %>% return()
}

# Call your `count_occurrences()` function to see how many times the letter 'e'
# is in your sentence.
count_occurences("a",SenSplit[[1]])

# Use `sapply()` to apply your `count_occurrences()` function to each unique 
# letter in the vector to determine their frequencies.
# Convert the result into a list (using `as.list()`).
Count_dla_sapply <- sapply(UniqLett,count_occurences,SenSplit[[1]])
Count_dla_sapply <- as.list(Count_dla_sapply)
# Print the resulting list of frequencies
Count_dla_sapply


# ROZDZIAL 10 - CZESC 1 ----------------------------------------------------

# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
seahawks <- c(45,45,40,13)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
seahawks_against <- c(13,9,33,33)

# Combine your two vectors into a dataframe called `games`
games <- data.frame(seahawks,seahawks_against)

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
games$diff <- games$seahawks-games$seahawks_against

# Create a new column "won" which is TRUE if the Seahawks won the game
games$won <- games$diff > 0

# Create a vector of the opponent names corresponding to the games played
opponent <- c("Hawks","Wizards","Jazz","Pacers")

# Assign your dataframe rownames of their opponents
rownames(games) <- opponent

# View your data frame to see how it has changed!
games

# RODZIAL 10 - CZESC 2 -----------------------------------------------------
# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"
employees <- paste("Employee ", c(1:100))

# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000
salaries <- runif(100,40000,50000)

# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.
adjustment <- runif(100,-5000,10000)

# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!
salaries <- data.frame(employees,salaries,adjustment)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
salaries$salary2018 <- salaries$salaries + salaries$adjustment

# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)
salaries$bonus <- salaries$adjustment>0


### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57
salaries[57,"salary2018"]

# How many employees got a raise?
nrow(salaries[salaries$bonus == TRUE,])

# What was the dollar value of the highest raise?
max(salaries$adjustment)

# What was the "name" of the employee who received the highest raise?
salaries[salaries$adjustment == max(salaries$adjustment),"employees"]

# What was the largest decrease in salaries between the two years?
min(salaries$adjustment)

# What was the name of the employee who recieved largest decrease in salary?
salaries[salaries$adjustment == min(salaries$adjustment),"employees"]

# What was the average salary change?
mean(salaries$adjustment)

# For people who did not get a raise, how much money did they lose on average?
mean(salaries[salaries$adjustment<0,"adjustment"])
write.csv(salaries,file="salaries.csv")

# ROZDZIA£ 10 - CZESC 3 ----------------------------------------------------

# Exercise 3: working with built-in data sets

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")

# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
is.data.frame(USPersonalExpenditure)

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data farm. Do this, storing the
# result in a new variable
Expenditure <- data.frame(USPersonalExpenditure)

# What are the column names of your dataframe?
colnames(Expenditure)

## Consider: why are they so strange? Think about whether you could use a number 
## like 1940 with dollar notation!

# What are the row names of your dataframe?
rownames(Expenditure)

# Add a column "category" to your data frame that contains the rownames
Expenditure$category <- rownames(Expenditure)

# How much money was spent on personal care in 1940?
Expenditure[4,1]

# How much money was spent on Food and Tobacco in 1960?
Expenditure[1,length(Expenditure)-1]

# What was the highest expenditure category in 1960?
Expenditure[Expenditure$X1960 == max(Expenditure$X1960),"category"]
Expenditure[1,1] <- 1
# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(years){
  
  Year1 <- paste0("X",years)
  return(Expenditure[Expenditure[[Year1]] == max(Expenditure[[Year1]]),"category"])
  
}

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
sapply(seq(1940,1960,5),lowest_category)


# ROZDZIAL 10 - CZESC 4 ----------------------------------------------------

# Exercise 4: external data sets: Gates Foundation Educational Grants

# Use the `read.csv()` functoin to read the data from the `data/gates_money.csv`
# file into a variable called `grants` using the `read.csv()`
# Be sure to set your working directory in RStudio, and do NOT treat strings as 
# factors!
gates <- read.csv(file = "C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-10-exercises/exercise-4/data/gates_money.csv",stringsAsFactors = FALSE)

# Use the View function to look at the loaded data
View(gates)

# Create a variable `organization` that contains the `organization` column of 
# the dataset
organization <- gates$organization

# Confirm that the "organization" column is a vector using the `is.vector()` 
# function. 
# This is a useful debugging tip if you hit errors later!
is.vector(organization)

## Now you can ask some interesting questions about the dataset

# What was the mean grant value?
mean(gates$total_amount)

# What was the dollar amount of the largest grant?
max(gates$total_amount)

# What was the dollar amount of the smallest grant?
min(gates$total_amount)

# Which organization received the largest grant?
gates[gates$total_amount == max(gates$total_amount),"organization"]

# Which organization received the smallest grant?
gates[gates$total_amount == min(gates$total_amount),"organization"]

# How many grants were awarded in 2010?
nrow(gates[gates$start_year == 2010,])


# ROZDZIAL 10 - CZESC 5 ---------------------------------------------------

# Exercise 5: large data sets: Baby Name Popularity Over Time

# Read in the female baby names data file found in the `data` folder into a 
# variable called `names`. Remember to NOT treat the strings as factors!
names <- read.csv(file = "C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-10-exercises/exercise-5/data/female_names.csv",stringsAsFactors = FALSE)

# Create a data frame `names_2013` that contains only the rows for the year 2013
names_2013 <- data.frame(names[names$year == 2013,])

# What was the most popular female name in 2013?
names_2013[names_2013$prop == max(names_2013$prop),"name"]

# Write a function `most_popular_in_year` that takes in a year as a value and 
# returns the most popular name in that year
most_popular_in_year <- function(year2){
  names <- data.frame(names[names$year == year2,])
  names[names$prop == max(names$prop),"name"]
}

# What was the most popular female name in 1994?
most_popular_in_year(1998)

# Write a function `number_in_million` that takes in a name and a year, and 
# returns statistically how many babies out of 1 million born that year have 
# that name. 
# Hint: get the popularity percentage, and take that percentage out of 1 million.
number_in_million <- function(name,year){
  names <- names[names$name == name & names$year == year,"prop"]
  return(names * 1000000)
}

# How many babies out of 1 million had the name 'Laura' in 1995?
number_in_million("Laura",1995)

# How many babies out of 1 million had your name in the year you were born?
number_in_million("Klaudia",1996)

## Consider: what does this tell you about how easy it is to identify you with 
## just your name and birth year?


# ROZDZIA£ 11 - CZESC 1 ---------------------------------------------------
library(dplyr)
# Exercise 1: working with data frames (review)

# Install devtools package: allows installations from GitHub
install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable


# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
length(unique(vehicles$make))

# Filter the data set for vehicles manufactured in 1997
cars1997 <- vehicles %>% filter(year == 1997)
cars97 <- vehicles[vehicles$year == 1997,]

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
vehicles %>% arrange(hwy)
cars97 <- cars97[order(cars97$hwy,decreasing = TRUE),]

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
cars1997 %>% mutate(average = (hwy+cty)/2)
cars97$average <- (cars97$hwy + cars97$cty)/2

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
Check <- vehicles %>% filter(cty > 20, drive == "2-Wheel Drive") 
Check2 <- vehicles[vehicles$cty >20 & vehicles$drive == "2-Wheel Drive",]

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
Check %>% filter(hwy == max(hwy)) %>% pull(id)
Check2[Check2$hwy == max(Check2$hwy),]

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
Autka <- function(year_choice, make_choice){
  
  vehicles %>% filter(year == year_choice, make == make_choice) %>% filter(hwy == max(hwy)) %>%  
    select(model) %>% pull(model)
}

# What was the most efficient Honda model of 1995?
Autka(1995,"Honda")


# ROZDZIAL 11 - CZESC 3 ---------------------------------------------------
# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
vehicles %>% filter(make == "Acura", year == 2015) %>% arrange(-hwy)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
arrange(filter(vehicles,make == "Acura", year == 2015),-hwy)

### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
Approach1 <- function(make_name,year_name,n){
  
  for(i in 1:n){
  vehicles1 <- filter(vehicles,make == make_name, year == year_name)
  veh_arr <- arrange(vehicles1,-hwy)
  return(veh_arr)
  }
}
  
Approach2 <- function(make_name,year_name,n){
  for(i in 1:n){
    vehicles1 <- arrange(filter(vehicles,make == make_name, year == year_name),-hwy)

    return(vehicles)
  }
}
  
Approach3 <- function(make_name,year_name,n){
  for(i in 1:n){
    vehicles1 <- vehicles %>% filter(make == make_name, year == year_name) %>% arrange(-hwy)
    return(vehicles)
  }
}

# RZODZIAL 11 - CZESC 4 ---------------------------------------------------

# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
Flights <- flights %>% mutate(gained = arr_delay- dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
Flights <- Flights %>% arrange(-gained)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
Flights <- flights %>% mutate(gained = arr_delay- dep_delay)%>% arrange(-gained)

# Make a histogram of the amount of time gained using the `hist()` function
hist(Flights$gained)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
Flights %>% summarise(Mean = mean(Flights$gained, na.rm = TRUE))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
SeaTac <- Flights %>% filter(dest == "SEA") %>% select(dest,gained)

# On average, did flights to SeaTac gain or loose time?
SeaTac %>% summarise(Mean = mean(SeaTac$gained, na.rm = TRUE))

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
Flights %>% filter(origin == "JFK", dest == "SEA") %>% summarise(mean = mean(Flights$gained, na.rm = TRUE), 
                                                                 max = max(Flights$gained, na.rm = TRUE),
                                                                 min = min(Flights$gained, na.rm = TRUE))

# ROZDZIAL 11 - CZESC 5 ---------------------------------------------------

# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- Flights %>% group_by(month) %>% summarise(mean = mean(dep_delay,na.rm = TRUE))

# Which month had the greatest average departure delay?
dep_delay_by_month %>% filter(mean == min(mean))

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
dep_delay_by_month %>% filter(mean == min(mean)) %>% plot()

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
dep_delay_by_dest <- Flights %>% group_by(dest) %>% summarise(mean = mean(arr_delay,na.rm = TRUE)) %>% arrange(-mean)

# You can look up these airports in the `airports` data frame!
dep_delay_by_dest <- Flights %>% group_by(dest) %>% summarise(mean = mean(arr_delay,na.rm = TRUE)) %>% arrange(-mean) %>% 
  left_join(airports, by = c("dest" = "faa"))

# Which city was flown to with the highest average speed?
flights %>% mutate(distpertime = distance / air_time) %>% group_by(dest) %>% summarise(mean = mean(distpertime,na.rm = TRUE)) %>% arrange(-mean)


# ROZDZIAL 11 - CZESC 6 ---------------------------------------------------

# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?

avarr <- flights %>% group_by(dest) %>% summarise(mean = mean(arr_delay,na.rm = TRUE)) %>% arrange(-mean) %>% 
  left_join(airports,by = c("dest" = "faa")) %>% select(name, mean)
  
# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
avarrairline <- flights %>% group_by(carrier) %>% summarise(mean = mean(arr_delay,na.rm = TRUE)) %>% arrange(-mean) %>% 
  left_join(airlines,by="carrier") %>% select(name,mean)

# ROZDZIAL 11 - CZESC 7 ---------------------------------------------------

# Exercise 7: using dplyr on external data

# Load the `dplyr` library


# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
nba <- read.csv("C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-11-exercises/exercise-7/data/nba_teams_2016.csv",stringsAsFactors = FALSE)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
dim(nba)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
nba <- nba %>% mutate(turnratio = TOV/STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
nba <- nba %>% arrange(turnratio)

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
nba <- nba %>% mutate(astgame = AST/G) %>% arrange(desc(astgame))

# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offense <- nba %>% filter(PTS > 8700)

# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defense <- nba %>% filter(BLK > 470)

# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense_stats <- nba %>% select(Team,ORB,FG.,AST)

# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defense_stats <- nba %>% select(Team,DRB,STL,BLK)

# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team1,team2){
  
  nba %>% filter(Team %in% c(team1,team2)) %>% filter(FG. == max(FG.)) %>% select(Team,FG.,PTS)
  
}

# Call the function on two teams to compare them (remember the `*` if needed)
better_shooters("Toronto Raports*","Miami Heat*")

# ROZDZIAL 11 - CZESC 8 ---------------------------------------------------

# Exercise 8: exploring data sets

# Load the `dplyr` library


# Read in the data (from `data/pulitzer-circulation-data.csv`). Remember to 
# not treat strings as factors!
pulitzer <- read.csv("C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-11-exercises/exercise-8/data/pulitzer-circulation-data.csv",stringsAsFactors = FALSE)

# View in the data set. Start to understand what the data set contains
View(pulitzer)

# Print out the names of the columns for reference
colnames(pulitzer)

# Use the 'str()' function to also see what types of values are contained in 
# each column (you're looking at the second column after the `:`)
# Did any value type surprise you? Why do you think they are that type?
str(pulitzer)

# Add a column to the data frame called 'Pulitzer.Prize.Change` that contains 
# the difference in the number of times each paper was a winner or finalist 
# (hereafter "winner") during 2004-2014 and during 1990-2003
pulitzer <- pulitzer %>% mutate(Pulitzer.Prize.Change = Pulitzer.Prize.Winners.and.Finalists..2004.2014 - Pulitzer.Prize.Winners.and.Finalists..1990.2003)

# What was the name of the publication that has the most winners between 
# 2004-2014?
pulitzermax <- pulitzer %>% filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 == max(Pulitzer.Prize.Winners.and.Finalists..2004.2014)) %>% 
  select(Newspaper)

# Which publication with at least 5 winners between 2004-2014 had the biggest
# decrease(negative) in daily circulation numbers?
publ <- pulitzer %>% filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 > 5) %>% 
  filter(Change.in.Daily.Circulation..2004.2013 == min(Change.in.Daily.Circulation..2004.2013))

# An important part about being a data scientist is asking questions. 
# Write a question you may be interested in about this data set, and then use  
# dplyr to figure out the answer!

#which publication which had below 100k circulation in 2004 increased the most
biggestrise <- pulitzer %>% filter(Daily.Circulation..2004 < 300000) %>% arrange(desc(Change.in.Daily.Circulation..2004.2013))
#Wrong results because it is character 


# ROZDZIA£ 12 - CZESC 1 ---------------------------------------------------

# Exercise 1: analyzing avocado sales with the `tidyr` package

# Load necessary packages (`tidyr`, `dplyr`, and `ggplot2`)
library(tidyr)
library(dplyr)
library(ggplot2)
# Set your working directory using the RStudio menu:
# Session > Set Working Directory > To Source File Location

# Load the `data/avocado.csv` file into a variable `avocados`
# Make sure strings are *not* read in as factors
avocados <- read.csv("C:/Users/woote/OneDrive/Pulpit/R/book-exercises/chapter-12-exercises/exercise-1/data/avocado.csv",stringsAsFactors = FALSE)

# To tell R to treat the `Date` column as a date (not just a string)
# Redefine that column as a date using the `as.Date()` function
# (hint: use the `mutate` function)
avocados <- avocados %>% mutate(Date = as.Date(Date), .keep = c("unused"))

# The file had some uninformative column names, so rename these columns:
# `X4046` to `small_haas`
# `X4225` to `large_haas`
# `X4770` to `xlarge_haas`
# The data only has sales for haas avocados. Create a new column `other_avos`
# that is the Total.Volume minus all haas avocados (small, large, xlarge)
avocados <- avocados %>% rename(small_haas = X4046,
                                large_haas = X4225,
                                xlarge_haas = X4770) %>% 
                        mutate(other_avos = Total.Volume - small_haas - large_haas - xlarge_haas)




# To perform analysis by avocado size, create a dataframe `by_size` that has
# only `Date`, `other_avos`, `small_haas`, `large_haas`, `xlarge_haas`
by_size <- avocados %>% select(Date, other_avos, small_haas, large_haas, xlarge_haas)

# In order to visualize this data, it needs to be reshaped. The four columns
# `other_avos`, `small_haas`, `large_haas`, `xlarge_haas` need to be 
# **gathered** together into a single column called `size`. The volume of sales
# (currently stored in each column) should be stored in a new column called 
# `volume`. Create a new dataframe `size_gathered` by passing the `by_size` 
# data frame to the `gather()` function. `size_gathered` will only have 3 
# columns: `Date`, `size`, and `volume`.
size_gathered <- gather(data = by_size,
                        key = size,
                        value = volume,
                        -Date)

# Using `size_gathered`, compute the average sales volume of each size 
# (hint, first `group_by` size, then compute using `summarize`)
size_gathered <- size_gathered %>% group_by(size) %>% summarise(aver_sales = mean(volume,na.rm = TRUE))

# This shape also facilitates the visualization of sales over time
# (how to write this code is covered in Chapter 16)
ggplot(size_gathered) +
  geom_smooth(mapping = aes(x = Date, y = volume, col = size), se = F) 


# We can also investigate sales by avocado type (conventional, organic).
# Create a new data frame `by_type` by grouping the `avocados` dataframe by
# `Date` and `type`, and calculating the sum of the `Total.Volume` for that type
# in that week (resulting in a data frame with 2 rows per week).
by_type <- avocados %>% group_by(Date,type) %>% 
  summarise(total = sum(Total.Volume))

# To make a (visual) comparison of conventional versus organic sales, you 
# need to **spread** out the `type` column into two different columns. Create a 
# new data frame `by_type_wide` by passing the `by_type` data frame to 
# the `spread()` function!
by_type_wide <- spread(by_type,key = type,value = total)

# Now you can create a scatterplot comparing conventional to organic sales!
# (how to write this code is covered in Chapter 16)
ggplot(by_type_wide) +
  geom_point(mapping = aes(x = conventional, y = organic, color = Date)) 











