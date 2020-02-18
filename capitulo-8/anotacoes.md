# EXUNIT

O Elixir automaticamente instala uma biblioteca para testes unitários chamada ExUnit. No exemplo deste capítulo, iremos criar uma calculadora, pois assim será mais fácil de identificarmos o resultado esperados pelos calculos, e trará mais foco aos testes do que a implementação em si.

A extensão `.exs` em Elixir significa que o arquivo não será compilado pela máquina virtual. `.exs` são uma espécie de arquivo de script que são apenas interpretados pela máquina.

Em `test_helper.exs` temos uma linha que inicializa o ExUnit.

Em `app_test.exs` é onde criaremos de fato os nossos testes. Ele é um módulo comum que faz uso de outro módulo chamado `ExUnit.case`. A chamada deste módulo dentro do teste dispara uma macro que permite escrever testes e asserts de forma amigável.

Para executar os testes basta entrar na pasta do projeto, e executar o seguinte comando:

```
mix test
```

O ExUnit também classifica testes com `tags`. Estas são úteis caso você precise executar um conjunto de testes enquanto mantém outros inativados. Para marcar os testes com tags, basta utilizarmos o `@moduletag :tag` para classificar o módulo inteiro, ou `@tag :tag` em cima de cada função. 

```
mix test --exclude tag # Exclui todos que contém esta tag
mix test --include tag # Inclui todos que contém esta tag
mix test --only tag # Apenas os que contém esta tag
```