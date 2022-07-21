# Gráficos para os slides


# aula 3 - metodologia II -------------------------------------------------

# I) ----------------------------------------------------------------------
p_n_ativo1 <- saudeJFCE::da_jfce |>
  dplyr::count(n_ativo) |>
  dplyr::add_row(n_ativo = 5, n = 0) |>
  dplyr::arrange(n_ativo) |>
  dplyr::mutate(n_ativo = forcats::fct_inorder(as.character(n_ativo))) |>
  ggplot2::ggplot() +
  ggplot2::aes(n_ativo, n, label = n) +
  ggplot2::geom_col(fill = cores_abj[1]) +
  ggplot2::geom_label() +
  ggplot2::labs(
    x = "Quantidade de pessoas no polo ativo",
    y = "Quantidade de processos"
  )

ggplot2::ggsave("slides/img/p_n_ativo1.png",
                p_n_ativo1, width = 10, height = 4)
# II) ---------------------------------------------------------------------

p_n_ativo2 <- saudeJFCE::da_jfce |>
  dplyr::mutate(
    dp = dplyr::if_else(tipo_autor == "defensoria pública", "sim", "não")
  ) |>
  dplyr::count(n_ativo, dp) |>
  dplyr::add_row(n_ativo = 5, n = 0) |>
  dplyr::arrange(n_ativo, dp) |>
  dplyr::mutate(
    n_ativo = forcats::fct_inorder(as.character(n_ativo)),
    dp = tidyr::replace_na(dp, "não")) |>
  ggplot2::ggplot() +
  ggplot2::aes(
    x = n_ativo,
    y = n,
    fill = dp,
    group = dp,
    label = n
  ) +
  ggplot2::geom_col(
    position = "dodge"
  ) +
  ggplot2::geom_label(
    fill = "white",
    position = ggplot2::position_dodge(width = .9)
  ) +
  ggplot2::scale_fill_manual(
    "É defensoria\npública?",
    values = c(cores_abj[1:2])
  ) +
  ggplot2::labs(
    x = "Quantidade de pessoas no polo ativo",
    y = "Quantidade de processos"
  )

ggplot2::ggsave("slides/img/p_n_ativo2.png",
                p_n_ativo2, width = 10, height = 4)
