# R basico ----------------------------------------------------------------

# o hashtag (#) serve para escrever comentários
# os comentários não são executados pelo R

# selecione um bloco de código e digite
# ctrl + shift + c para comentar tudo o que está selecionado

# ATALHO para rodar o código: CTRL + ENTER
# Mesmo atalho no Mac: Command + ENTER

# adição
1 + 1
# subtração
4 - 2
# multiplicação
2 * 3
# divisão
5 / 3
# com ponto
1.5 + 1
# potência
4 ^ 2
4 ** 2

# criar objetos/variáveis
# coloca o valor 1 no objeto "obj". Podemos usar esses valores depois
obj <- 2
obj = 2

# Também dizemos 'guardando as saídas'
soma <- 2 + 2
soma

# ATALHO para <- : ALT + - (alt menos)
# Mesmo atalho no Mac: Option + - (Option menos)

# salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# atualizar um objeto
resultado <- resultado * 5
resultado

# O R difencia minúscula de maiúscula!
a <- 5
A <- 42
a
A

# 1a <- 3

# textos
a <- "ola, sou um texto"

# Vetores são conjuntos de valores

vetor1 <- c(1, 4, 3, 10)
vetor2 <- c("a", "b", "z")

vetor1
vetor2

# Podemos acessar elementos do vetor pela sua posição. Começa pelo 1!
vetor <- c("a", "b", "c", "d")

vetor[1]
vetor[3]

vetor[c(2, 3)]
vetor[c(1, 2, 4)]

# Também podemos acessar por exclusão

vetor[-1]
vetor[-c(2, 3)]

# Se tentarmos misturar dois tipos, o R vai converter

vetor <- c(1, 2, "a")
vetor

# Podemos fazer operações matemáticas com vetores

vetor <- c(0, 5, 20,-3)

vetor + 1
vetor - 1
vetor / 2
vetor * 10

# Funções são nomes que guardam um código de R.

# Por exemplo, usamos a função `c()` para criar vetores

c(1, 3, 5)

vetor_exemplos <- c(1, 5, 3.4, 7.23, 2.1, 3.8)

# Exemplos
length(vetor_exemplos)   # comprimento
sum(vetor_exemplos)      # soma
mean(vetor_exemplos)     # média
sd(vetor_exemplos)       # desvio padrão
paste("a", "b")          # cola os elementos, separando com um espaço
paste0("a", "b")         # cola os elementos sem separar!

paste(c("a", "b"), collapse = "")
paste("a", "b", sep = " oi ")

# HELP
?paste
help(paste)

# pacotes -----------------------------------------------------------------

# A forma de disponibilizar funções para que outras pessoas possam
# utilizar é através de pacotes.

# Um pacote no R é um conjunto de funções, bases de dados, textos que
# explicam o que as funções fazem, tutoriais, etc.

# o pacote que vamos instalar se chama "tidyverse"
# mais sobre aqui: https://tidyverse.org

# para instalar um pacote você usa install.packages("nomeDopacote")
# e aplica ela num texto, entre aspas. As aspas são importantes!

install.packages("tidyverse")

# a função library deixa todas as funções que fazem parte do pacote tidyverse
# disponíveis pra você utilizar.

library(tidyverse)
library(readxl)

# install.packages("tidyverse") -> apenas uma vez
# library(tidyverse) -> toda vez que você abrir o R

# library(abjData)
# leiloes
# consumo
# litigiosidade

# importacao --------------------------------------------------------------

litigiosidade <- read_csv("m1/exercicios/litigiosidade.csv")
litigiosidade <- read_xlsx("m1/exercicios/litigiosidade.xlsx")

glimpse(litigiosidade)

view(litigiosidade)

# transformacao -----------------------------------------------------------

# pipe

sin(exp(sqrt(sum(c(1, 2, 3)))))

c(1, 2, 3) |>
  sum() |>
  sqrt() |>
  exp() |>
  sin()

## funcoes do pacote dplyr

glimpse(litigiosidade)

# ordenar com arrange()

litigiosidade |>
  arrange(pop)

litigiosidade |>
  arrange(desc(pop))

litigiosidade |>
  arrange(ano, pop)

litigiosidade |>
  arrange(ano, desc(pop))

# filtro com filter()

litigiosidade |>
  filter(ano == 2015) |>
  view()

litigiosidade |>
  filter(ano > 2015)

litigiosidade |>
  filter(ano >= 2015)

litigiosidade |>
  filter(ano <= 2017)

litigiosidade |>
  filter(ano <= 2016, pop > 10000000)

# selecao com select()

litigiosidade |>
  filter(ano == 2015) |>
  select(tribunal = tribunal_uf, baixados, novos, pendentes)

litigiosidade |>
  filter(ano == 2015) |>
  select(justica:novos)

litigiosidade |>
  filter(ano == 2015) |>
  select(ends_with("s"))

litigiosidade |>
  filter(ano == 2015) |>
  select(where(is.character))

litigiosidade |>
  filter(ano == 2015) |>
  select(where(is.numeric))

# criar colunas com mutate()

litigiosidade |>
  select(ano, tribunal_uf, novos, baixados, pop) |>
  mutate(
    ilg = novos / pop * 100000,
    iad = baixados / novos
  )

# sumarizar com summarise()

litigiosidade |>
  filter(ano == 2015) |>
  summarise(
    media_novos = mean(novos),
    sd_novos = sd(novos)
  )

litigiosidade |>
  summarise(
    media_novos = mean(novos),
    sd_novos = sd(novos),
    .by = c(ano)
  )

litigiosidade |>
  group_by(ano) |>
  summarise(
    media_novos = mean(novos),
    sd_novos = sd(novos)
  )

