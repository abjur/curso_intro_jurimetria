googlesheets4::gs4_auth("rfeliz@abj.org.br")

# base para a aula de tipos de variáveis ----------------------------------

q1 <- quantile(abjData::consumo$valor, 0.25)
q3 <- quantile(abjData::consumo$valor, 0.75)

consumo_modificada <- abjData::consumo |>
  dplyr::transmute(
    id_processo,
    assunto,
    comarca,
    valor,
    valor_faixa = dplyr::case_when(
      valor < q1 ~ "Baixo",
      valor > q3 ~ "Alto",
      TRUE ~ "Médio"
    ),
    dec_val,
    dec_unanime,
    dec_date,
    tempo
  ) |>
  dplyr::rowwise() |>
  dplyr::mutate(n_partes_ativo = sample(1:3, 1))

glossario_consumo_modificada <- tibble::tibble(
  coluna = colnames(consumo_modificada),
  descricao = c(
    "Número identificador do processo",
    "Assunto do processo",
    "Comarca em que tramita o processo",
    "Valor da ação",
    "Faixa de valor da ação (Baixo, Médio e Alto)",
    "Resultado da decisão (Não reformou, Reformou, Parcial, Desistênca, Não conheceram / Prejudicado / Diligência",
    "Resultado da votação (Unânime, Maioria)",
    "Data da decisão",
    "Tempo transcorrido até a decisão (em dias)",
    "Quantidade de partes no polo ativo da demanda"
  )
)
