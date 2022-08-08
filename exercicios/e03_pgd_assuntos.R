assuntos_tjam <- abjData::assuntos |>
  dplyr::filter(tribunal == "TJAM") |>
  dplyr::group_by(assunto_nome1, assunto_nome2, assunto_nome3, assunto_nome4, assunto_nome5, assunto_nome6) |>
  dplyr::summarise(
    n = sum(total)
  ) |>
  dplyr::ungroup()

googlesheets4::gs4_auth("rfeliz@abj.org.br")

googlesheets4::write_sheet(
  assuntos_tjam,
  "https://docs.google.com/spreadsheets/d/1W0a0MPpszNYEbS6x8ytDwYF78rcU8_qhgOO4ke22sSw/edit#gid=0",
  "assuntos"
)
