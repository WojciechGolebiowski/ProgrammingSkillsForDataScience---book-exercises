# UI for scatterplot
library(shiny)
library(ggplot2)

# Get a vector of column names (from `mpg`) to use as select inputs
mpg_names <- colnames(mpg)
# Create a variable `x_input` that stores a `selectInput()` for your
# variable to appear on the x axis of your chart.
# Use the vector of column names as possible values, and make sure
# to assign an inputId, label, and selected value
x_input <- selectInput("x_var","Please select the name for x axis:",choices = mpg_names,selected = 'year')

# Using a similar approach, create a variable `y_input` that stores a
# `selectInput()` for your variable to appear on the y axis of your chart.
# Add a `selectInput` for the `y` variable
y_input <- selectInput("y_var","Please select the name for y axis:",choices = mpg_names,selected = 'cyl')

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
color_input <- selectInput("col1","Please select the color:",choices =c("red","pink","navy","blue"))

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in your `geom_point()`
size_input <- sliderInput("size","Select point size:",min = 0.5, max = 4, value = 2)

# Create a variable `ui` that is a `fluidPage()` ui element. 
# It should contain:
ui <- fluidPage(
  # A page header with a descriptive title
  "Analysis of a chart",

  # Your x input
  x_input,
  
  # Your y input
  y_input,
  
  # Your color input
  color_input,
  
  # Your size input
  size_input,
  
  # Plot the output with the name "scatter" (defined in `app_server.R`)
  plotOutput("scatter")
)
