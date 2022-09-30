# exercícios de medidas

da <- abjData::litigiosidade |>
  dplyr::transmute(
    ano,
    tribunal_uf,
    baixados,
    novos,
    pendentes,
    ` ` = NA_character_,
    `  ` = NA_character_,
    `   ` = NA_character_,
    `    ` = NA_character_,
    `     ` = NA_character_,
    `      ` = NA_character_
  )

# googlesheets4::gs4_auth("rfeliz@abj.org.br")

sheet <- "https://docs.google.com/spreadsheets/d/1Z2YAufjiCQmTXm3Vw18Ul0Esnr1RZNxljgaohWcWclo/edit#gid=0"

googlesheets4::write_sheet(
  data = da,
  sheet,
  "litigiosidade"
)

