# ui.R
library(shiny)
library(plotly)

# Define a variable `map_sidebar_content` that is a `sidebarPanel()` for your
# first (map) page that contains:
  # An input to select variable to map
map_sidebar_content <- sidebarPanel(
  selectInput("var","Please select variable:",choices = list("Ratio" = "ratio", "Population" = "population", "Votes" = "votes"))
)
# Define a variable `map_main_content` that is a `mainPanel()` for your
# first (map) page that contains the `plotlyOutput()` of your map
map_main_content <- mainPanel(
  plotlyOutput("map")
)
# Create a variable `map_panel` that stores a `tabPanel()` for your first page
# It should include the following:
  # A `sidebarLayout()` that contains...
map_panel <- tabPanel(title = "Map",
                      titlePanel("Map"),
                      sidebarLayout(
                      map_sidebar_content,
                      map_main_content))    
    # Your `map_sidebar_content`
    
    # Your `map_main_content`


# Define a variable `scatter_sidebar_content` that is a `sidebarPanel()` for 
# your second (scatter) page that contains:
# - a `textInput()` widget for searching for a state in your scatter plot
scatter_sidebar_content <- sidebarPanel(
  textInput("state","Please type in a state:",value ="")
)

# Define a variable `scatter_main_content` that is a `mainPanel()` for your
# second (scatter) page that contains the `plotlyOutput()` of your scatter
scatter_main_content <- mainPanel(
  plotlyOutput("scatter")
)

# Create a variable `scatter_panel` that stores a `tabPanel()` for your 2nd page
# It should include the following:
  scatter_panel <- tabPanel(title = "SCATTER",
                            titlePanel("Scatter"),
                            sidebarLayout(
                            scatter_sidebar_content,
                            scatter_main_content))
  # Add a titlePanel to your tab
  
  # Create a sidebar layout for this tab (page)
    
    # Display your `scatter_sidebar_content`
    
    
    # Display your `scatter_main_content`
    
# Define a variable `ui` storing a `navbarPage()` element containing
# your two pages defined above
ui <- navbarPage(title = "Elections",
                 map_panel, 
                 scatter_panel)
