da_aulas <- tibble::tibble(
  semana=1,
  tipo_conteudo="",
  duracao=0,
  conteudo=""
) |>
  dplyr::add_row(
    semana=2,
    tipo_conteudo="Metodologia",
    duracao=42,
    conteudo="Operacionalização de conceitos"
  ) |>
  dplyr::add_row(
    semana=2,
    tipo_conteudo="Estatística",
    duracao=18,
    conteudo="Tipos de variáveis"
  ) |>
  dplyr::add_row(
    semana=2,
    tipo_conteudo="Programação",
    duracao=90,
    conteudo="Introdução ao R"
  ) |>
  dplyr::add_row(
    semana=3,
    tipo_conteudo="Metodologia",
    duracao=25,
    conteudo="Definição de escopo"
  ) |>
  dplyr::add_row(
    semana=3,
    tipo_conteudo="Estatística",
    duracao=17,
    conteudo="Tabela de frequência"
  ) |>
  dplyr::add_row(
    semana=3,
    tipo_conteudo="Estatística",
    duracao=44,
    conteudo="Medidas de centro"
  ) |>
  dplyr::add_row(
    semana=3,
    tipo_conteudo="Programação",
    duracao=27,
    conteudo="Tabela de frequência no R"
  ) |>
  dplyr::add_row(
    semana=4,
    tipo_conteudo="Metodologia",
    duracao=39,
    conteudo="Processo de geração de dados"
  ) |>
  dplyr::add_row(
    semana=4,
    tipo_conteudo="Estatística",
    duracao=30,
    conteudo="Medidas de dispersão I"
  ) |>
  dplyr::add_row(
    semana=4,
    tipo_conteudo="Estatística",
    duracao=24,
    conteudo="Medidas de dispersão II"
  ) |>
  dplyr::add_row(
    semana=4,
    tipo_conteudo="Programação",
    duracao=32,
    conteudo="Como calcular medidas no R"
  ) |>
  dplyr::add_row(
    semana=5,
    tipo_conteudo="Metodologia",
    duracao=37,
    conteudo="Viés de seleção"
  ) |>
  dplyr::add_row(
    semana=5,
    tipo_conteudo="Metodologia",
    duracao=60,
    conteudo="Teorema de Priest & Klein"
  ) |>
  dplyr::add_row(
    semana=5,
    tipo_conteudo="Estatística",
    duracao=28,
    conteudo="Gráfico de barras"
  ) |>
  dplyr::add_row(
    semana=5,
    tipo_conteudo="Estatística",
    duracao=18,
    conteudo="Histograma"
  ) |>
  dplyr::add_row(
    semana=5,
    tipo_conteudo="Programação",
    duracao=17,
    conteudo="Introdução à visualização no R (ggplot2)"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Metodologia",
    duracao=46,
    conteudo="Técnica de pesquisa I"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Metodologia",
    duracao=27,
    conteudo="Técnica de pesquisa II"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Estatística",
    duracao=22,
    conteudo="Boxplot"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Estatística",
    duracao=15,
    conteudo="Séries temporais"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Estatística",
    duracao=10,
    conteudo="Gráfico de dispersão"
  ) |>
  dplyr::add_row(
    semana=6,
    tipo_conteudo="Programação",
    duracao=50,
    conteudo="Como criar as visualizações no R"
  ) |>
  dplyr::mutate(
    semana = as.character(semana),
    extra = tipo_conteudo == "Programação",
    tipo_aula = dplyr::case_when(
      extra ~ "Extra",
      TRUE ~ "Aula"
    )
  ) |>
  dplyr::transmute(
    "Tipo" = tipo_aula,
    "Semana" = semana,
    "Conteúdo" = conteudo,
    "Tipo de conteúdo" = tipo_conteudo,
    "Duração" = paste0(duracao, " min")
  )

# se eu estiver no local
googlesheets4::gs4_auth("rfeliz@abj.org.br")

# 2) salva o link
link <- "https://docs.google.com/spreadsheets/d/18tnjl8wwRZaFw_fUwt1OGue00w4cN5-9_ZF4PPPoBhk/edit#gid=0"

# 4) roda tudo :)
googlesheets4::write_sheet(
  da_aulas,
  link,
  "cronograma"
)
