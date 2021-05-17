# Load libraries so they are available
library("shiny")

# We'll begin by defining some of the UI elements as variables
# This helps keep the code organized and easier to debug

# Define a variable `intro_panel` for your first page. It should be a
# `tabPanel()` with a title "Introduction" to represent the first tab.
# This layout will contain the following elements:
  intro_panel <- tabPanel(title = "Introduction",
  # A `titlePanel()` with the text "Income Inequality"
  titlePanel("Introduction"),
  p("The below diagram was created by the New York Times to illustrate the increasing level of inequality in the US"),
  # A paragraph `p()` describing with the text: "The below diagram was created
  # by the New York Times to illustrate the increasing level of inequality in
  # the US."
  img(src = "inequality.png"),

  # An image `img()` to display. This content should have a `src` attribute of
  # "inequality.png" (which will refer to the file in the `www/` folder).
  

  # A paragraph containing a hyperlink `a()` to the source of the article at
  # https://www.nytimes.com/interactive/2017/08/07/opinion/leonhardt-income-inequality.html
  p(a("https://www.nytimes.com/interactive/2017/08/07/opinion/leonhardt-income-inequality.html")),

  # A paragraph containing a 1-2 sentence description of what the diagram
  # shows. Your paragraph should include both `strong()` and emphasized `em()`
  # text.
  p(em("The picture"),strong("shows:"))
  )
# Next, we'll define a few UI elements to render in our second panel

# Define a variable `sidebar_content` as a `sidebarPanel()` UI element
# containing the following information:
  sidebar_content <- sidebarPanel(
  # A `sliderInput()` for the 'percentile' value, labeled "Income Percentile".
  # This slider should let the user pick a range between 0 and 100
  sliderInput("percentile","Income Percentile",min=0,max=100,value = c(0,100))
  )
# Define a variable `main_content` as a `mainPanel()` UI element
# containing the following information:
main_content <- mainPanel(
  # A `plotOutput()` element showing the 'plot' output (defined in the server)
  plotOutput("plot"),
  p(a("http://gabriel-zucman.eu/usdina/"))
  # A paragraph with a hyperlink to the data source
  # http://gabriel-zucman.eu/usdina/
)
# Define a variable `growth_panel` for your second page. It should be a
# `tabPanel()` with a title "Growth Chart" to represent the second tab.
# This layout will contain the following elements:
growth_panel <- tabPanel(title = "Growth Chart",
                         titlePanel("Income growth 1980-2004"),
                         sidebarLayout(sidebarPanel = sidebar_content, mainPanel = main_content))
  # A `titlePanel()` with the text "Income growth 1980-2014"
  

  # A `sidebarLayout()` to create two columns.
  # The sidebar layout will contain elements:

    # Your `sidebar_content`

    # Your `main_content`
    

# Finally, define a `ui` variable, assigning it a `navbarPage()` layout.
# You will use `shinyUI()` to render this variable (in `app.R`)
# Give the layout a title of "Income Inequality".
# The layout should include the following elements:
# - Your `intro_panel`
# - Your `growth_panel`
ui <- navbarPage(title = "App",intro_panel, growth_panel)
