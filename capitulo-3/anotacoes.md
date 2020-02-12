# Organização

Praticamente todo código escrito em Elixir vive dentro de módulos. Eles são similares a classes em outras linguagens, e atuam como uma espécie de repositório de funcionalidades.

Quando você precisar resolver um problema em Elixir, provavelmente você criará um módulo, e dentro dele, as funções necessárias para solucionar o problema.

Um particularidade, é que em Elixir podemos escrever múltiplas funções com o mesmo nome, mesmo número de argumentos e do mesmo tipo! Isso porque cada função pode ter um padrão na sua assinatura e as chamadas de funções podem sr organizadas por padrão em vez de número de argumentos ou tipos.

## Pattern Matching

O Pattern Matching é uma funcionalidade que serve para decompor estruturas complexas em estruturas mais simples. Em Elixir, até mesmo o que parece ser uma atrbuição de valor a uma variável realiza o Pattern Matching por trás das cenas.

Abaixo, o que está acontecendo é um "match" de x com 10 que Elixir usa para realizar uma espécie de "bind". Quando fazemos a operação contrária, ela também funcionará:

```
x = 10
10

10 = x
10
```

Contudo, se tentarmos fazer o match com valores que não batem, receberemos um erro.

A partir do básico do Pattern Matching, podemos avançar para entendermos quais as vantagens desse recurso disponível:

```
{:carro, modelo} = {:carro, "Honda"}

modelo
"Honda"
```

Se tentarmos fazer o match com atoms diferentes, também receberemos um erro.

Podemos fazer também pular valores que não nos interessam, para isso, podemos usar um simples _ (underscore).

```
{_, numero} = {"não interessa", 500}
{"não interessa", 500}

numero
500

{_, _, numero} = {1, 2, 500}
{1, 2, 500}

numero
500
```

No processo de match, existe um caractere especial ^ (cincunflexo), que podemos utilizar para impedir um possível rebind.

```
[a, b] = [1, 2]
[1, 2]

a + b
3

[a, b] = [3, 4]

a + b
7

[^a, b] = [5, 6]
** (MatchError) no match of right hand side value: [5, 6]
```

## Módulos

Módulo é o mecanismo usado para agrupar funções e lógica que você deseja reaproveitar. List e String são exemplos de módulos nativos. Para isso, utilizamos a palavra reservada `defmodule`, seguida do nome do módulo, por exemplo, `defmodule Multiplicador`.

Você pode criar módulos para armazenar funções úteis que poderiam ser reutilizadas por outros módulos.

Utilizaremos como exemplo o arquivo chamado `"multiplicador.ex"` localizado aqui nessa pasta. Lá explicaremos um pouco sobre declarações de funções, funções de uma linha e funções privadas.

Também é possível que aninhemos módulos, e temos duas maneiras de fazer isso: uma é escrevendo literalmente um módulo dentro do outro, e a outroa é usando a notação de pontos.

Por exemplo, suponhamos que você precise organizar as finanças por entradas e saídas, e queira uma função calcular para ambas, então você faria: `Financas.Entradas.calcular` e `Financas.Saidas.calcular`.

Exemplos relacionados ao aninhamento de módulos estão no arquivo `modulos_aninhados.ex`.

## Funções

Podemos criar funções sem argumentos e até mesmo sem nomes! Funções anônimas são úteis quando você precisa passar uma função como argumento, e ela é tão específica e autoexplicativa que não há necessidade de criar um nome para ela.

Funções são cidadãs de primeira classe dentro do paradigma funcional.

Existem diversas maneiras de se declarar funções anônimas dentro de Elixir, contudo, sempre que invocarmos essa função anônima, precisaremos chamá-la antes dos parenteses com o . (ponto), caso contrário, ocorrerá um erro quando tentarmos invocar a função.

```
multiplicador = fn a, b -> a * b end

multiplicador.(2, 4)
8

multiplicador.(3, 2)
6

multiplicador(2, 4)
** (CompileError) iex4: undefined function multiplicador/2
```

Outra maneira de se criar funções anônimas é utilizando &. Para isso, utilizamos primeiro o & seguido do corpo da função (). Seu argumentos são nomeados com &1, &2, &3 e assim por diante.

```
soma = &(&1 + &2)

soma.(2, 2)
4

multiplica_e_soma = &(&1 + &2 * &3)

multiplica_e_soma.(2, 2, 1)
5
```

## Funções e Pattern Matching

Funções também podem ter várias assinaturas diferentes, e o Elixir consegue fazer isso porque utiliza o reconhecimento de padrões que vimos anteriormente. Abaixo, teremos um exemplo de uma função que possui múltiplas assinaturas, que reconhecerá o padrão do atom que será enviado como argumento e retornará o conteúdo correspondente.

Caso não nos importemos com o padrão, basta utilizarmos o _ (underscore), É importante saber que geralmente ele é usado no final da expressão, porque a leitura é realizada de cima para baixo.

```
escreva_o_nome = fn
:tiago -> "Seu nome é Tiago"
:davi -> "Seu nome é Davi"
_ -> "Não me importo qual é o seu nome"
end

escreva_o_nome.(:tiago)
"Seu nome é Tiago"

escreva_o_nome.(:davi)
"Seu nome é Davi"

escreva_o_nome.(:jonas)
"Não me importo qual é o seu nome"
```


