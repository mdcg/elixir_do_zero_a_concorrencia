# Mix

O Mix é uma CLI para construção de projetos, gerenciamento de dependências e execução de tarefas. Ele já vem instalado por padrão junto com o Elixir, então apenas digite no terminal `mix new <nome_do_projeto>`. O Mix gerará para você toda a estrutura do projeto, com todas as pastas necessárias para executá-lo.

Uma convensão, pelo menos para esse projeto, é que chamaremos de `app`. Abaixo segue o comando:

```
mix new app
```

O `README.md` descreve o que o projeto faz. Ele também informa algumas coisas interessantes, como a possibilidade de você incluir seu projeto ao `HEX`, que é o gerenciador de dependências do Elixir.

O `mix.exs` gerencia todas as dependências do projeto. É apenas um módulo, no qual é possível incluir dependências que o prejeto precisa carregar. Ainda nele, a função `application` carrega as dependências externas necessárias antes de carregar a aplicação principal. Já a função `deps` carrega e faz o download de todas as dependências.

O `tests` contém todos os testes do projeto.

O `lib` contém todos os arquivos que você precisa para executar o projeto. É uma convensão criar novos módulos dentro de uma pasta com o mesmo nome do projeto dentro de `lib`. No nosso caso, caso fossemos criar um arquivo chamado `hello.ex`, como o nome do nosso projeto é `app`, o caminho final dele seria `lib/app/hello.ex`.

**Para executar o projeto**, você precisa entrar na pasta dele e digitar:

```
iex -S mix
```

O `config` contém toda a configuração do projeto. Nele, existe um arquivo previamente criado com todas as informações básicas de configuração. Podemos usar este arquivo de configuração para passar argumentos para toda a aplicação. Isso é útil, por exemplo, para verificarmos se a aplicação está em teste, desenvolvimento ou produção.

Para executar a aplicação com configurações personalizadas, podemos chamar o nome do módulo que as contém da seguinte maneira:

```
MIX_ENV=prod iex -S mix
```

Por fim, a pasta `build` contém os arquivos compilados.