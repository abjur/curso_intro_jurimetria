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
