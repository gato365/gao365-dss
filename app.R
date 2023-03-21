library(shiny)
library(tidyverse)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
    theme = bs_theme(
      bg = "#1D7874",
      fg = "white",
      primary = "pink",
      base_font = font_google("JetBrains Mono"),
      heading_font = font_google("Climate Crisis"),
    ),

    # Application title
    titlePanel("Mtcars Dataset"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
        selectInput("graph_type",
                    label = h3("Graph Type"),
                    choices = c("box", "histogram", "violin", "scatter"),
                    selected = 1),
        conditionalPanel("input.graph_type == 'scatter' ||
                          input.graph_type == 'violin'",
                         selectInput("y_var",
                              label = h3("Y Variable"),
                              choices = c("mpg", "disp", "hp", "wt"),
                              selected = 1),
                         ),  
        selectInput("x_var",
                    label = h3("X Variable"),
                    choices = c("mpg", "disp", "hp", "wt"),
                    selected = 1),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("distPlot"),
          verbatimTextOutput("textoutput_1")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        #x    <- mtcars[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white',
         #    xlab = 'Waiting time to next eruption (in mins)',
          #   main = 'Histogram of waiting times')
        
        if(input$graph_type == "box") {
          mtcars %>% 
            ggplot(aes_string(x=input$x_var)) + 
            geom_boxplot()
        } else if(input$graph_type == "histogram") {
          mtcars %>%
            ggplot(aes_string(x=input$x_var)) +
            geom_histogram()
        } else if(input$graph_type == "violin") { 
          mtcars %>%
            ggplot(aes_string(x=input$x_var, y=input$y_var)) +
            geom_violin()
        } else { # scatter
          mtcars %>%
            ggplot(aes_string(x=input$x_var, y=input$y_var)) + 
            geom_point()
        }
    })
    # output$textoutput_1 <- renderPrint({input$slider2})
}

# Run the application 
shinyApp(ui = ui, server = server)
