# **CSL4050 Lab 8**
 
# Iris Data Visualization App

This Shiny app allows you to visualize the Iris dataset using histograms, a scatter plot, and a box plot. You can customize the bin size and color of the histograms, the x and y axes of the scatter plot, the color of the scatter plot by species, and the point size and shape of the scatter plot. You can also filter the data by species using a checkbox input.

## How to Use

* Install the required libraries: `shiny`,  `plotly`, and `dplyr`.
* Load the Iris dataset: `data(iris)`.
* Run the app using `shinyApp(ui, server)`.

## Inputs

### **Histograms**
* Bin Size (Sepal Length): Numeric input for the bin size of the Sepal Length histogram.
* Bin Size (Sepal Width): Numeric input for the bin size of the Sepal Width histogram.
* Bin Size (Petal Length): Numeric input for the bin size of the Petal Length histogram.
* Bin Size (Petal Width): Numeric input for the bin size of the Petal Width histogram.
* Histogram Color (Sepal Length): Select input for the color of the Sepal Length histogram.
* Histogram Color (Sepal Width): Select input for the color of the Sepal Width histogram.
* Histogram Color (Petal Length): Select input for the color of the Petal Length histogram.
* Histogram Color (Petal Width): Select input for the color of the Petal Width histogram.

### **Scatter Plot**

* X-Axis: Select input for the x-axis of the scatter plot.
* Y-Axis: Select input for the y-axis of the scatter plot.
* Color by Species: Select input for the color of the scatter plot by species.
* Filter by Species: Checkbox input for filtering the data by species.
* Point Size: Slider input for the size of the points in the scatter plot.
* Point Shape: Select input for the shape of the points in the scatter plot.

## Outputs

* Sepal Length Histogram: Histogram of Sepal Length.
* Sepal Width Histogram: Histogram of Sepal Width.
* Petal Length Histogram: Histogram of Petal Length.
* Petal Width Histogram: Histogram of Petal Width.
* Scatter Plot: Scatter plot of the selected x and y axes, colored by species and filtered by species.
* Box Plot: Box plot of the selected y axis, grouped by species.

## Code Explanation

The app loads the required libraries `shiny`, `plotly`, and `dplyr`, and the Iris dataset. The UI is defined using `fluidPage`, with a sidebar panel for inputs and a main panel for plots. The sidebar panel includes numeric inputs for the bin size of the histograms, select inputs for the color of the histograms and scatter plot by species, select inputs for the x and y axes of the scatter plot, a checkbox input for filtering the data by species, and slider and select inputs for the point size and shape of the scatter plot. The main panel includes plotly outputs for the histograms, scatter plot, and box plot.

The server is defined using `function(input, output)`, with separate `renderPlotly` functions for each plot. The histograms are created using `plot_ly` with the selected bin size and color inputs, and the scatter plot is created using `plot_ly` with the selected x and y axes, color by species, and filtered by species using `dplyr::filter`. The point size and shape are added using 
`add_markers`. The box plot is created using `plot_ly` with the selected y axis and grouped by species.

Finally, the app is run using `shinyApp(ui, server)`.