# bases para a aula de tabela de frequência --------------------------------------------------

link_tabela_frequencia <- "https://docs.google.com/spreadsheets/d/1-7b4xt0o68sh9fZ-zJ3m16AeoE4mBhHcVnhtmJUUbIg/edit#gid=0"

googlesheets4::gs4_auth("rfeliz@abj.org.br")
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


# no R --------------------------------------------------------------------

saudeJFCE::da_jfce  |>
  dplyr::select(id_processo, assunto, decisao_sentenca) |>
  dplyr::mutate(
    decisao_sentenca = dplyr::case_when(
      is.na(decisao_sentenca) ~ "ainda não foi decidido",
      decisao_sentenca == "desfavoravel" ~ "desfavorável",
      TRUE ~ decisao_sentenca
    ),
    assunto = forcats::fct_lump_min(assunto, min = 30, other_level = "Outros")
  ) |>
  dplyr::count(assunto) |>
  dplyr::mutate(
    prop = round(n/sum(n), 2)
  ) |>
  dplyr::arrange(desc(n)) |>
  dplyr::mutate(
    n_cum = cumsum(n),
    prop_cum = cumsum(prop)
  ) |>
  janitor::adorn_totals() |>
  dplyr::mutate(
    n_cum = dplyr::case_when(
      assunto == "Total" ~ ".",
      TRUE ~ as.character(n_cum)
    ),
    prop_cum = dplyr::case_when(
      assunto == "Total" ~ ".",
      TRUE ~ as.character(prop_cum)
    )
  ) |>
  knitr::kable()

