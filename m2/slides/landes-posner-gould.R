library(shiny)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      width = 6,
      fluidRow(
        column(6, sliderInput("sp", "Sp", 0, 100, 0)),
        column(6, sliderInput("sd", "Sd", 0, 100, 0))
      ),
      fluidRow(
        column(6, sliderInput("cp", "Cp", 0, 100, 20)),
        column(6, sliderInput("cd", "Cd", 0, 100, 20))
      ),
      fluidRow(
        sliderInput("j", "J", 1, 1000, 100)
      ),
      fluidRow(
        column(6, sliderInput("pp", "Pp", 0, 1, .5, step = 0.01)),
        column(6, sliderInput("pd", "Pd", 0, 1, .3, step = 0.01))
      )
    ),
    mainPanel(
      width = 6,
      plotly::plotlyOutput("plot", 400, 400),
      textOutput("texto")
    )
  )
)

server <- function(input, output, session) {


  output$plot <- plotly::renderPlotly({

    validate(need(
      input$cp + input$cd - input$sp - input$sd > 0,
      "O modelo supõe custo do processo deve ser maior que o custo do acordo."
    ))

    limite <- (input$cp + input$cd - input$sp - input$sd) / input$j
    dados <- tibble::tibble(pp = input$pp, pd = input$pd)

    p <- ggplot2::ggplot(dados, ggplot2::aes(pp, pd)) +
      ggplot2::geom_abline(intercept = -limite, slope = 1) +
      ggplot2::geom_point(colour = "red", size = 3) +
      ggplot2::scale_x_continuous(limits = c(0, 1)) +
      ggplot2::scale_y_continuous(limits = c(0, 1)) +
      ggplot2::coord_fixed() +
      ggplot2::labs(x = "Pp", y = "Pd")

    plotly::ggplotly(p)

  })

  output$texto <- renderText({

    validate(need(
      input$cp + input$cd - input$sp - input$sd > 0,
      "O modelo supõe custo do processo deve ser maior que o custo do acordo."
    ))

    limite <- (input$cp + input$cd - input$sp - input$sd) / input$j
    dados <- tibble::tibble(pp = input$pp, pd = input$pd)

    if (input$pp - input$pd > limite) {
      "Decisão: Litígio"
    } else {
      "Decisão: Acordo"
    }

  })

}

shinyApp(ui, server)
