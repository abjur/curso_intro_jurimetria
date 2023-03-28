library(shiny)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(6, sliderInput("infop", "Informacao autor (log)", 0, 5, 1, .1)),
        column(6, sliderInput("infod", "Informacao reu (log)", 0, 5, 1, .1))
      ),
      fluidRow(
        column(12, sliderInput("n", "Quantidade de simulacoes", 1, 10000, step = 1000, 1000)),
        column(12, sliderInput("ys", "Valor limite", 0.1, 3, 1, .1))
      ),
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
        actionButton("rodar", "Rodar simulacao")
      )
    ),
    mainPanel(
      plotly::plotlyOutput("litigar", 800, 400),
      plotly::plotlyOutput("decisao", 800, 400),
      textOutput("txt_qtd"),
      textOutput("txt_prop")
    )
  )
)

server <- function(input, output, session) {


  y <- shiny::reactive({
    rgamma(input$n, 5, 6)
  }) |> bindEvent(input$rodar, input$n)

  pd <- shiny::reactive({
    sig <- 1 / exp(input$infod)
    yd <- rnorm(input$n, sd = sig) + y()
    pnorm((yd - input$ys) / sig)
  })

  pp <- shiny::reactive({
    sig <- 1 / exp(input$infop)
    yp <- rnorm(input$n, sd = sig) + y()
    pnorm((yp - input$ys) / sig)
  })

  limite <- shiny::reactive({
    (input$cp + input$cd - input$sp - input$sd) / input$j
  })

  output$litigar <- plotly::renderPlotly({

    dif <- tibble::tibble(x = pp(), y = pd(), litigou = x > y + limite()) |>
      dplyr::mutate(litigou = dplyr::if_else(litigou, "Sim", "Nao")) |>
      ggplot2::ggplot() +
      ggplot2::aes(x, y, colour = litigou) +
      ggplot2::geom_point() +
      ggplot2::geom_abline(slope = 1, intercept = -limite()) +
      ggplot2::labs(
        x = "Pp", y = "Pd", colour = "Litigou"
      ) +
      ggplot2::scale_colour_manual(
        values = viridis::viridis(2, 1, .2, .8)
      ) +
      ggplot2::theme_minimal()

    plotly::ggplotly(dif)

  })

  output$decisao <- plotly::renderPlotly({


    dados <- tibble::tibble(
      x = y(),
      litigou = pp() - pd() > limite()
    ) |>
      dplyr::mutate(litigou = dplyr::if_else(litigou, "Litigou = Sim", "Litigou = Nao"))

    p <- ggplot2::ggplot(dados, ggplot2::aes(x, fill = litigou)) +
      ggplot2::geom_density(alpha = .9, show.legend = FALSE) +
      ggplot2::geom_vline(
        ggplot2::aes(text = "Valor limitrofe", xintercept = input$ys),
        colour = 2, linetype = 2
      ) +
      ggplot2::labs(
        x = "Merito", y = "Densidade", fill = "Litigou"
      ) +
      ggplot2::facet_wrap(~litigou, scales = "free_y") +
      ggplot2::scale_fill_manual(
        values = viridis::viridis(2, 1, .2, .8)
      ) +
      ggplot2::theme_minimal()

    plotly::ggplotly(p)


  })



  output$txt_qtd <- renderText({

    n_litig <- sum(pp() - pd() > limite())

    glue::glue("Quantidade de litigios em {input$n} simulacoes: {n_litig}")

  })

  output$txt_prop <- renderText({

    litigou <- pp() - pd() > limite()
    prop_vitoria <- mean(y()[litigou] > input$ys)
    glue::glue("Proporcao de vitorias: {scales::percent(prop_vitoria)}")

  })

}

shinyApp(ui, server)
