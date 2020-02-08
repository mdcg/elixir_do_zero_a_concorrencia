# Fundamentos

Antes de ser executado pela máquina virtual, todo código Elixir é compilado.

Elixir compila para a mesma estrutura que Erlang, então é totalmente possível usar funções do Erlang dentro do Elixir sem problema algum.

Elixir é contruído com Elixir! A maioria dos recursos presentes na linguagem foram desenvolvidos usando a própria linguagem através de metaprogramação e macros.

**Elixir sempre retorna um resultado**. Tudo dentro de Elixir é considerado uma expressão e toda expressão deve retornar um valor. 

Em Elixir também não há declarações sem retorno de valor. Declarações são todas as instruções que um programador pode especificar para um computador executar.

Dentro de Elixir existe uma função muito interessante para que você possa inspecionar seus exemplos de código e analisar melhor o que está acontecendo em seu programa.

A função **inspect/2** é responsável por converter qualquer estrutura em Elixir para uma string amigavelmente formatada, o que é ótimo para debuggar o código.

**NUNCA USE O inspect/2 COMO UM TIPO DE To.String!! É ERRADO!**

## Tipos

### Numéricos

Basicamente constituída por inteiros e pontos flutuantes.

Números inteiros grandes ser escritos com underscore para facilitar a leitura:

```
1_000
10_000
100_000
1_000_000
```

Pontos flutuantes por sua vez só precisam do ponto:

```
1.0
7.2
49.7
```

Operações matemáticas funcionam como esperado, com exceção da divisão:

```
4+2
6

8-3
5

7*7
49

4/2
2.0
```

Na divisão acontece uma transformação implícita que recebe os inteiros como argumento e retorna um ponto flutuate.

Se você quiser resultados inteiros, você deve utilizar funções próprias para isso:

```
div(4,2)
2

rem(4,2)
0
```

**PS:** rem() é a função que retorna o resto.

### Binários, hexadecimais e octais

Elixir possui diferentes prefixos para converter determinadas bases numéricas em outras:

```
0b11111 # Prefixo 0b binário em decimal
15

0xf # Prefixo 0x para hexadecimal em decimal
15

0o17 # Prefixo 0o octal em decimal
```

### Atoms

Atoms são constantes e seu nome é seu valor em si mesmo. Eles são classificados como "simbolos" em outras linguagens, como por exemplo Ruby, e podemos representá-los acrescentando : (dois pontos) seguido de um nome, que pode conter também _, @, !, ?.

Ele são bastante utilizados para sinalizar sucesso, erro e chaves de dicionários.

Atoms com o mesmo nome são sempre iguais mesmo que tenham sido criados por aplicações diferentes em computadores diferentes! Eles não são mutáveis e nem coletados pelo Garbage Collector.

```
:ok

:error

:funciona?

:exclua!

:nome_com_sobrenome
```

Existem funções especificas para transformar Atoms em strings e vice-versa:

```
Atom.to_string(:exclua!)
"exclua!"

String.to_atom("funciona?")
:funciona?
```

### Booleanos

Basicamente existem apenas três tipos de booleanos: true, false e nil. Todos eles são atalhos para atoms de mesmo nome, então true é a mesma coisa que :true, e assim por diante.

Na maioria dos contextos, **qualquer valor diferente de false e nil é tratado como true**, inclusive o zero!

```
0 || false
0

0|| nil
0
```

Os operados abaixo esperam apenas true ou false como argumentos, caso você tente passar nil, você terá um erro de ArgumentError:

```
a or b
a and b
not a
```

Abaixo, os operadores esperam argumentos de qualquer tipo, porém, **qualquer valor diferente de nil ou false é true**.

```
a || b
a && b
!a
```

Operadores de comparação:

```
a === b
a !== b
a == b
a != b
a > b
a >= b
a < b
a <= b
```

Você pode usar a função boolean/1 para checar se um argumento é booleano.

### Strings

Strings são caracteres UTF-8 envolvidos por aspas duplas. Elas podem ser escritas diretamente com quebra de linha, aceitam heredoc (documentação entre caracteres de abertura e fechamento) e interpolação.

```
"Livro de Elixir"

"Livro
de Elixir"

a = Elixir
"Livro de #{a}"

"2 + 2 é igual a #{2+2}"
```

Heredocs são mais comuns para escrever documentações e podemos usá-los utilizando aspas triplas.

```
"""
Minha primeira
documentação de
exemplo.
"""
```

Elixir também possui diversas funções para manipular strings, como é o caso da String.reverse/1, String.length/1, String.capitalize/1

### Listas

Listas são um tipo de coleção de elementos que podem conter diversos outros tipos dentro dela. O conceito de **listas** é que **podem ter head e tail**.

**Listas são imutáveis**! Você nunca terá uma cópia de uma lista ao remover ou adicionar elementos, o que você terá é uma nova lista.

```
[1,2,3,4,5] ++ [6,7,8,9,10] # Mais custoso

lista = [1,2,3,4,5]
nova_lista = [6,7,8,9,10 | lista] |> Enum.sort # Menos custoso
```

Para pegarmos o head usamos a função hd/1, já para o tail, tl/1:

```
hd([1,2,3])
1

tl([1,2,3])
[2,3]
```

### Tuplas

Tuplas são similares a listas, contudo, escrevemos dentro de {} ao invés de []. A principal diferença entre elas é que acessar elementos individuais em uma tupla é mais rápido. Contudo, crescer e adicionar mais elementos pode ser custoso, coisa que não acontece com listas.

```
{"livros", 10, true, :funciona?}
```

Existem diversas funções pra trabalhar com tuplas, como o tuple_size/1 e elem/2:

```
tupla = {"livros", 10, true, :funciona?, 1.5}

tuple_size tupla
5

elem tupla, 2
"livro"
```

A função put_elem/3 permite atualizar um elemento dentro da tupla:

```
tupla = {:john, 20}

put_elem tupla, 1, 25
{:john, 25}
```

Uma coisa que você deve ter notada é que executamos algumas funções sem (). Isso significa que nem sempre precisamos ser tão verbosos, porque Elixir permite que eliminemos coisas desnecessárias privilegiando a legibilidade.

### Mapas

Mapas são coleções chave/valor. Os valores de mapas podem ser acessados através de suas chaves.

Geralmente, as chaves do mapa são do mesmo tipo, mas não é obrigatório. Se você **usar atoms como chaves**, você **ganha a habilidade de acessar os mapas através de mapa.chave**. 

```
mapa1 = %{"chave1" => "valor1", chave2 => "valor 2"}
mapa2 = %{chave1: 1, chave2: 2, chave3: "valor 3"}

mapa1["chave1"]
"valor1"

mapa1["chave2"]
nil

mapa1[:chave2]
"valor 2"

mapa1.chave2
"valor 2"

mapa1.chave3
** (KeyError) key :chave3 not found in: %{"chave1" => "valor1", chave2 => "valor 2"}

mapa2[:chave1]
1

mapa2[:chave2]
2

mapa2[:chave3]
"valor 3"

mapa2.chave1
1

mapa2.chave2
2

mapa2.chave3
"valor 3"
```