
library(abjData)
library(tidyverse)

dados <- litigiosidade |>
  select(ano, tribunal_uf,
         novos, baixados, pendentes)

# média de casos novos
mean(dados$novos)

# média de casos novos por uf
media_por_estado <- dados |>
  group_by(tribunal_uf) |>
  summarise(media = mean(novos))

# média de casos novos por uf e ano
media_por_estado_ano <- dados |>
  group_by(tribunal_uf, ano) |>
  summarise(media = mean(novos), .groups = "drop")

# mediana de casos novos
median(dados$novos)

# desvios
dados_com_desvios <- dados |>
  mutate(
    desvio = novos - mean(novos),
    desvio_absoluto = abs(desvio),
    desvio_quadrado = desvio^2
  )

dados_com_desvios |>
  summarise(
    media_desvios = mean(desvio),
    desvio_medio = mean(desvio_absoluto),
    variancia = mean(desvio_quadrado),
    desvio_padrao = sqrt(variancia)
  ) |>
  pivot_longer(everything()) |>
  mutate(value = format(value, scientific = FALSE))

sqrt(sum(dados_com_desvios$desvio_quadrado) /
  (nrow(dados_com_desvios)))

sd(dados$novos)

# calcular os percentis

percentis <- quantile(dados$novos, probs = c(0, 0.25, 0.5, 0.75, 1))

# amplitude e IQR

amplitude <- percentis[5] - percentis[1]
amplitude <- diff(range(dados$novos))

IQR <- percentis[4] - percentis[2]

IQR
