# Load required libraries
library(shiny)
library(plotly)
library(dplyr)

# Load Iris data
data(iris)

# Define UI for app
ui <- fluidPage(
# Sidebar panel for inputs
sidebarPanel(
# Bin size input for histograms
numericInput("bin_size1", "Bin Size (Sepal Length):", 10),
numericInput("bin_size2", "Bin Size (Sepal Width):", 10),
numericInput("bin_size3", "Bin Size (Petal Length):", 10),
numericInput("bin_size4", "Bin Size (Petal Width):", 10),

# Color inputs for histograms
selectInput("hist_color1", "Histogram Color (Sepal Length):",
            choices = c("blue", "red", "green", "purple"), selected = "blue"),
selectInput("hist_color2", "Histogram Color (Sepal Width):",
            choices = c("blue", "red", "green", "purple"), selected = "red"),
selectInput("hist_color3", "Histogram Color (Petal Length):",
            choices = c("blue", "red", "green", "purple"), selected = "green"),
selectInput("hist_color4", "Histogram Color (Petal Width):",
            choices = c("blue", "red", "green", "purple"), selected = "purple"),

# Scatter plot inputs
selectInput("x_axis", "X-Axis:", choices = names(iris)[-5], selected = "Sepal.Length"),
selectInput("y_axis", "Y-Axis:", choices = names(iris)[-5], selected = "Sepal.Width"),

# Color inputs for scatter plot
selectInput("color_species", "Color by Species:", choices = unique(iris$Species), selected = "setosa"),

# Checkbox input to filter by species
checkboxGroupInput("filter_species", "Filter by Species:",
                    choices = unique(iris$Species), selected = unique(iris$Species)),

# Point size and shape inputs for scatter plot
sliderInput("point_size", "Point Size:", min = 1, max = 10, value = 5),
selectInput("point_shape", "Point Shape:", choices = c("circle", "square", "triangle"), selected = "circle")

),

# Main panel for plots
mainPanel(
# Histograms
div(plotlyOutput("hist1"), style = "height: 400px; width: 400px;"),
div(plotlyOutput("hist2"), style = "height: 400px; width: 400px;"),
div(plotlyOutput("hist3"), style = "height: 400px; width: 400px;"),
div(plotlyOutput("hist4"), style = "height: 400px; width: 400px;"),

# Scatter plot
div(plotlyOutput("scatter"), style = "height: 400px; width: 800px;"),

# Box plot
div(plotlyOutput("box"), style = "height: 400px; width: 800px;")

)
)

# Define server for app
server <- function(input, output) {

# Histograms
output$hist1 <- renderPlotly({ plot_ly(iris, x = ~Sepal.Length, type = "histogram", color = ~Species, colors = c(input$hist_color1, "orange", "purple"), height = "100%", width = "100%") %>%

layout(title = "Sepal Length Histogram", xaxis = list(title = "Sepal Length"), yaxis = list(title = "Count"))

})

output$hist2 <- renderPlotly({ plot_ly(iris, x = ~Sepal.Width, type = "histogram", color = ~Species, colors = c(input$hist_color2, "orange", "purple"), height = "100%", width = "100%") %>%
layout(title = "Sepal Width Histogram", xaxis = list(title = "Sepal Width"), yaxis = list(title = "Count"))
})

output$hist3 <- renderPlotly({ plot_ly(iris, x = ~Petal.Length, type = "histogram", color = ~Species, colors = c(input$hist_color3, "orange", "purple"), height = "100%", width = "100%") %>%
layout(title = "Petal Length Histogram", xaxis = list(title = "Petal Length"), yaxis = list(title = "Count"))
})

output$hist4 <- renderPlotly({ plot_ly(iris, x = ~Petal.Width, type = "histogram", color = ~Species, colors = c(input$hist_color4, "orange", "purple"), height = "100%", width = "100%") %>%
layout(title = "Petal Width Histogram", xaxis = list(title = "Petal Width"), yaxis = list(title = "Count"))
})

# Scatter plot
output$scatter <- renderPlotly({ plot_ly(dplyr::filter(iris, Species %in% input$filter_species), x = as.formula(paste0("~", input$x_axis)), y = as.formula(paste0("~", input$y_axis)), color = ~Species, colors = c("blue", "red", "green"), height = "100%", width = "100%") %>%
add_markers(size = input$point_size, symbol = input$point_shape) %>%
layout(title = "Scatter Plot", xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
})

# Box plot
output$box <- renderPlotly({ plot_ly(iris, x = ~Species, y = as.formula(paste0("~", input$y_axis)), type = "violin", box = list(visible = TRUE), color = ~Species, colors = c("blue", "red", "green"), height = "100%", width = "100%") %>%
layout(title = "Box Plot", xaxis = list(title = "Species"), yaxis = list(title = input$y_axis))
})
}

# Run the app
shinyApp(ui, server)
