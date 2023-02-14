## Configuração inicial de um curso

1. [RStudio] criar repo da turma com usethis (usethis::create_project())
2. [RStudio] configurar git e github com usethis (usethis::use_git() e usethis::use_github())
3. [Terminal] adicionar submodulo (git add submodule <link repo principal> materiais/)
4. [RStudio/Terminal] commit e push (verificar se submodulo funcionou)
5. [RStudio] adicionar coisas de site (logo, _config.yml, README.Rmd)
6. [RStudio] adicionar action (rodar usethis::use_github_actions() e depois copiar _pages.yml de outro repo)
7. [GitHub] adicionar secret no GitHub (pegar aqui: gitcreds::gitcreds_get()$password), com o nome PAGES_PAT
8. [GitHub] habilitar github pages (github actions´beta)
9. [RStudio] modificar e knitar README.Rmd
10. [RStudio/Terminal] commit e push
11. [GitHub] mudar metadados do site

## Modificando slides durante as aulas:

1. entrar em materiais/
2. editar
3. commit e push
4. voltar para o repo principal
5. commit e push

## Modificando slides depois do curso:

Se o repo `curso_intro_jurimetria` for modificado, os links do repo da turma não vão quebrar. 

Ou seja, depois do curso, podemos desenvolver por aqui, sem problemas. Nesse caso, não devemos atualizar o repo da turma (ele deve ficar congelado).

