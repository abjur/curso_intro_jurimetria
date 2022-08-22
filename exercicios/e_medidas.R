link_gabarito <- "https://docs.google.com/spreadsheets/d/17KxDCNXDgE6v1yNiXETyyd1RmetYAMs8LjNYs4J1UXU/edit#gid=0"

link_exercicio <- "a fazer"

# Exercício 1 - Tabela de frequência

da_categorica <- abjData::consumo |>
  dplyr::select(id_processo, assunto, dec_val) |>
  dplyr::mutate(
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

googlesheets4::gs4_auth("rfeliz@abj.org.br")

googlesheets4::write_sheet(
  da_categorica,
  link_gabarito,
  "Exercício 1"
)

# Exercício 2
da_central <- abjData::pnud_min |>
  dplyr::mutate(
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  ) |>
  dplyr::select(-lat, -lon) |>
  dplyr::filter(ano == 2010)

googlesheets4::gs4_auth("rfeliz@abj.org.br")

googlesheets4::write_sheet(
  da_central,
  link_gabarito,
  "Exercício 2"
)

# Exercício 3
da_desvio <- abjData::pnud_min |>
  dplyr::select(ano, muni_id, muni_nm, uf_sigla, regiao_nm, idhm) |>
  dplyr::filter(ano == 2010) |>
  dplyr::mutate(
    desvio = NA_character_,
    modulo_desvio = NA_character_,
    desvio_quadrado = NA_character_,
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

googlesheets4::gs4_auth("rfeliz@abj.org.br")

googlesheets4::write_sheet(
  da_desvio,
  link_gabarito,
  "Exercício 3"
)

# Exercício 4
da_quantil <- readr::read_delim("~/Downloads/ciee.csv", delim = ";") |>
  dplyr::transmute(
    ano,
    tribunal_uf,
    novos_por_100k = round((novos+baixados+pendentes)/pop * 100000, 2),
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

googlesheets4::gs4_auth("rfeliz@abj.org.br")

googlesheets4::write_sheet(
  da_quantil,
  link_gabarito,
  "Exercício 4"
)
