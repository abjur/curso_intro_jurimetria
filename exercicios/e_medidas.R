googlesheets4::gs4_auth("rfeliz@abj.org.br")

# bases para a aula de tabela de frequência --------------------------------------------------

link_tabela_frequencia <- "https://docs.google.com/spreadsheets/d/1-7b4xt0o68sh9fZ-zJ3m16AeoE4mBhHcVnhtmJUUbIg/edit#gid=0"

# base simples

set.seed(30)
da_simples <- saudeJFCE::da_jfce |>
  dplyr::sample_n(30) |>
  dplyr::select(id_processo, assunto) |>
  dplyr::mutate(
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

googlesheets4::write_sheet(
  da_simples,
  link_tabela_frequencia,
  "Base simples"
)

# base grande
da_grande <- saudeJFCE::da_jfce |>
  dplyr::select(id_processo, assunto, decisao_sentenca) |>
  dplyr::mutate(
    decisao_sentenca = dplyr::case_when(
      is.na(decisao_sentenca) ~ "ainda não foi decidido",
      decisao_sentenca == "desfavoravel" ~ "desfavorável",
      TRUE ~ decisao_sentenca
    ),
    assunto = forcats::fct_lump_min(assunto, min = 30, other_level = "Outros")
  ) |>
  dplyr::mutate(
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_,
    `       ` = NA_character_,
    `        ` = NA_character_,
    `         ` = NA_character_

  )

googlesheets4::write_sheet(
  da_grande,
  link_tabela_frequencia,
  "Base grande"
)

# bases para os exercícios de medidas ---------------------------------------------------
link_gabarito <- "https://docs.google.com/spreadsheets/d/17KxDCNXDgE6v1yNiXETyyd1RmetYAMs8LjNYs4J1UXU/edit#gid=0"

link_exercicio <- "https://docs.google.com/spreadsheets/d/18icIOI2XZX4NR54upLsN0CnLRkyeo6ryQYsTKrZQxL0/edit#gid=0"


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

googlesheets4::write_sheet(
  da_categorica,
  link_exercicio,
  "Tabela de frequência"
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

googlesheets4::write_sheet(
  da_central,
  link_exercicio,
  "Medidas de centro"
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

googlesheets4::write_sheet(
  da_desvio,
  link_exercicio,
  "Medidas de dispersão I"
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

googlesheets4::write_sheet(
  da_quantil,
  link_exercicio,
  "Medidas de dispersão II"
)

# Exerecício 5

set.seed(1)
da_gsheets <- abjData::consumo |>
  dplyr::sample_n(20) |>
  dplyr::transmute(
    id_processo,
    assunto,
    dec_val,
    dec_date,
    valor = as.character(valor),
    valor_corrigido = NA_character_,
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

googlesheets4::write_sheet(
  da_gsheets,
  link_exercicio,
  "Formatação de dados"
)
