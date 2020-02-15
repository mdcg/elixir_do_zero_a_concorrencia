# Listas

## Head e Tail

Uma lista em Elixir consiste de `head` e `tail`. Logo, o head seria a cabeça, ou nesse caso, o primeiro valor da lista, já a tail, a cauda, seria o restante da lista. Isso significa, que caso tenhamos apenas um elemento em nossa lista, ele ainda possuirá head/tail, sendo o elemento em si o head e o restante da lista [].

```
[1] = [1 | []]
[1, 2] = [1 | [2 | []]]
[1, 3] = [1 | [2 | [3 | []]]]
```

Podemos utilizar o pipe para fazermos o pattern matching do head e tail da lista, sendo que o que fica à esquerda do operador pip é o head, e o que fica à direita é o tail.

```
[head | tail] = [1,2,3,4,5,6,7,8,9,10]

head
1

tail
[2,3,4,5,6,7,8,9,10]
```

PS: Você não precisa chamá-lo de head/tail, contudo, é uma convensão e boa prática chamá-los desse modo; a não ser que você chame de algo que represente melhor o contexto da aplicação.

## List Comprehension

Em Elixir, uma maneira funcional de percorrer coleções é a chamada `List Comprehension`. Basicamente, ele possui a capacidade de gerar coleções a partir de outras coleções.

Esse mecanismo é utilizado onde você normalmente utilizaria loops ou laços em outras linguagens. Há um macro chamado `for` que nos ajuda nesse propósito.

```
for x <- [1,2,3], do: x * 2
[2,4,6]
```

Também podemos utilizar filtros na macro, fazendo com que somente elementos que passem no filtro sejam colocados na lista que será criada.

```
for x <- [1,2,3,:tiago,:davi], is_atom(x), do: x
[:tiago, :davi]

for x <= [1,2,3,:tiago,:davi], is_integer(x), do: x
[1,2,3]
```

Você também pode criar sua própria função customizada para filtrar elementos na macro for.

```
estudantes = [{"Daniel", 15}, {"Philip", 27}, {"Joana", 19}]

maior_idade = fn {nome, idade} -> idade >= 18 end

for estudante <- estudantes, maior_idade.(estudante), do: estudante
[{"Philip", 27}, {"Joana", 19}]
```

Podemos criar novas estruturas e fazer o Pattern Matching.

```
for x <- [1,2,3,:tiago,:davi], is_integer(x), do: {x, x * 2}
[{1, 2}, {2, 4}, {3, 6}]

for {nome, aparelho} <- [{"tiago", "PS4"}, {"davi", "PS3"}, {"jonas", "PS2"}], do: nome
["tiago", "davi", "jonas"]

for {nome, aparelho} <- [{"tiago", "PS4"}, {"davi", "PS3"}, {"jonas", "PS2"}], do: aparelho
["PS4", "PS3", "PS2"]

for {nome, aparelho} <- [{"tiago", "PS4"}, {"davi", "PS3"}, {"jonas", "PS2"}], do: %{nome: nome, aparelho: aparelho}
[%{nome: "tiago", aparelho: "PS4"}, %{nome: "davi", aparelho: "PS3"}, %{nome: "jonas", aparelho: "PS2"}]
```

Você pode também percorrer duas listas ao mesmo tempo. Dado que você tenha duas ou mais coleções, as operações serão aninhadas:

```
for a <- [1,2], b <- [3,4], do: {a,b}
[{1,3}, {1,4}, {2, 3}, {2, 4}]

for a <- [1,2], b <- [3,4], do: a + b
[4,5,5,6]
```

Até agora, retornamos uma lista depois da execução do comprehension, contudo, podemos mudar esse comportamento com o uso da palavra reservada `into`.

```
for {nome, aparelho} <- [{"Tiago", "PS4"}, {"Davi", "PS3"}, {"Jonas", "PS2"}], into %{}, do: {nome, aparelho}
%{"Tiago" => "PS4", "Davi" => "PS3", "Jonas" => "PS2"}
```

Podemos também utilizar algumas funções conhecidas para nos auxiliar.

```
for {nome, aparelho} <- [{"Tiago", "PS4"}, {"Davi", "PS3"}, {"Jonas", "PS2"}], into %{}, do: {nome |> String.downcase |> String.to_atom, aparelho}
%{tiago: "PS4", davi: "PS3", jonas: "PS2"}
```

## Lazy Evaluation

Carregamento lento (lazy evaluation) é um recurso presente na linguagem para evitar carregarmos dados desnecessários em memória. Isso é muito útil para lidar com coleções cujo tamanho não sabemos, ou algum arquivo pesado que não pode ser carregado todo de uma vez.

Em Elixir, já vemos o módulo `Enum`, que é muito útil para lidar com coleções, contudo, ele potencialmente carrega toda a coleção em memória e, consequentemente, nos devolve uma nova coleção.

Imagine user este módulo para carregar milhares de registros, ou melhor, um arquivo de 50gb! Isso provavelmente demorará bastante, ou até mesmo travará a sua máquina.

Para resolver esse tipo de problema, temos o módulo `Stream`, que faz o carregamento de informações somente quando elas são necessárias. Ele não devolve uma nova coleção, ele devolve uma stream de dados que representa informação contida nela. Esse recurso é chamado `Lazy Evaluation`.

Um bom exemplo para demonstrar a diferença entre o carregamento rápido e o lento é esse:

```
Enum.map(1..20_000_000, &(&1)) |> Enum.take(10)
```

Agora utilizaremos o mesmo exemplo com a Stream:

```
Stream.map(1..20_000_000, &(&1)) |> Enum.take(10)
```

Basicamente, o Enum.take(10) pegou os 10 primeiros elementos de uma lista, a diferença foi que mapear com Enum carregou tudo em memória (20 milhões), enquanto com Stream carregou somente o que precisou (Somente 10).

PS: O Stream não é uma bala de prata, então só utilize ele em casos onde precisamos atrasar o carregamento de informações, quando precisar de parte de algo muito maior ou quando tiver que lidar com arquivos muito grandes.

O Stream consome muitos recursos que o uso do Enum, então usá-lo em situações nas quais ele não deveria ser aplicado, poder ter o efeito contrário e reduzir ao invés de ganhar performance.

## Recursividade

Recursividade é a capacidade de uma função executar a si mesma, múltiplas vezes, até resolver um determinado problema. Elixir ajuda bastante na implementação de funções recursivas, pois podemos usar o Pattern Matching em conjunto para eliminar boa parte do processo.

Criamos uma função em `contador.ex` que exemplifica bem o jeito Elixir de lidar com recursividade.
