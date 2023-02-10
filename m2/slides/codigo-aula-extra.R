

1+1

a <- 3

library(ggplot2)
library(dplyr)
library(abjData)


# transformacao dos dados -------------------------------------------------

litigiosidade_plot <- litigiosidade |> 
  filter(justica == "Estadual", ano == 2020) |> 
  transmute(
    tribunal_uf,
    litig = novos / pop * 100000,
    idhm
  )


# exploracao --------------------------------------------------------------

litigiosidade_plot |> 
  ggplot() +
  aes(x = idhm, y = litig) +
  geom_point()


# otimizacao --------------------------------------------------------------

litigiosidade_plot |> 
  ggplot() +
  aes(x = idhm, y = litig) +
  geom_text(
    aes(label = tribunal_uf),
    color = "darkblue",
    size = 4
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    colour = "lightgray"
  ) +
  theme_minimal(14) +
  labs(
    x = "Índice de Desenvolvimento Humano",
    y = "Litigiosidade\n(casos novos por 100.000 habitantes)",
    title = "Litigiosidade e Desenvolvimento",
    caption = "Fonte: CNJ e IBGE"
  )
