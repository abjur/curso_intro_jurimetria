
link_dados <- "https://docs.google.com/spreadsheets/d/1-7b4xt0o68sh9fZ-zJ3m16AeoE4mBhHcVnhtmJUUbIg/edit#gid=1184480235"

library(googlesheets4)
library(tidyverse)

dados <- read_sheet(link_dados, sheet = 3)

tabela_frequencias <- dados |>
  count(assunto, decisao_sentenca) |>
  mutate(
    proporcao = n / sum(n),
    frequencia_acumulada = cumsum(n),
    proporcao_acumulada = cumsum(proporcao)
  )

library(writexl)

write_xlsx(
  tabela_frequencias,
  "data-raw/a_frequencia_resultado.xlsx"
)
