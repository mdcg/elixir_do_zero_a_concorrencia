# Verificação

## Controle de fluxo

Para lidar com controle de fluxo, existem mecanismos tradicionais como o if/else. Porém, existem alguns não muito tradicionais como o unless, que é o contrário do if, e alguns mais modernos, como o case.

É importante saber que esses mecanismos não são construções especiais como na maioria das outras linguagens. Em Elixir, eles são conhecidos como `macros` que são exatamente como qualquer função básica.

```
x = 10

if x do
"x tem valor válido"
else
"x é nil ou false"
end

"x tem valor válido"
```

Não há obrigatoriedade de usar o else.

O unless vem de linguagens como o Ruby, e funciona da mesma maneira:

```
unless x == 10 do
"x não é 10"
else
"x é 10 sim"
end

"x é 10 sim"
```

Existem também as expressões if/else de apenas uma linha:

```
if true, do: 1 + 2
3

if false, do: :tiago, else: :davi
:davi
```

Quando precisamos checar diversas condições e encontrar a primeira condição válida, podemos utilizar a macro `cond`.

```
cond do
2 + 2 == 5 -> "Isso não é verdade"
2 + 2 == 6 -> "Isso também não é verdade"
2 + 2 == 4 -> "Ok, você acertou"
end
"Ok, você acertou"
```

É interessante saber que caso nenhuma condição seja válida, você terá um erro: `(CondClauseError) no cond clause evaluated to a true value`.

A macro `case` nos permite tentar casar um valor com vários padrões até encontrarmos um que corresponde e faça match com sucesso.

```
case :tiago do
:davi   -> "Isso não casa com :tiago"
10      -> "Isso muito menos"
:jonas  -> "Estou ficando cansado.."
:tiago  -> "Ok, você casou :tiago com :tiago"
end
"Ok, você casou :tiago com :tiago"
```

PS: _ (underscore) é um coringa que casa com tudo. Ele é similar ao "default" em outra linguagens.

## Guard clauses

Guard clauses são expressões que você implementa para garantir, por exemplo, que determinada função só pode receber um tipo de argumento, ou que seu argumento deve passar por determinada condição para ser válido.

```
case {1,2,3} do
{1,x,3} when x > 0 -> "Isso vai casar porque 2 é maior que zero"
_ -> "Isso casaria se não tivesse casado antes"
end
"Isso vai casar porque 2 é maior que zero"
```

Você também pode usar guard clauses dentro de funções. Caso nenhuma clause bater, você receberá um erro, por isso, é importante escrever um código que verifique as possíveis exceções.

```
minha_funcao = fn
a, b when a > 0 and b == 10 -> a + b
a, b when is_atom(a) -> "#{a} é um atom"

minha_funcao.(1, 10)
11

minha_funcao.(1, 11)
** (FunctionClauseError) no function clause matching in :erl_eval......

minha_funcao.(:tiago)
"tiago é um atom"
```

Existem uma série de funções iniciadas com "is_" que você pode utilizar em guard clauses, como: is_atom/1, is_float/1, is_list/1, is_map/1, is_port/1, is_bitstring/1

## Operador Pipe

O operador pip |> é algo bem simples, mas que facilita demais na hora de escrever código Elixir. Basicamente ele pega a saída da expressão da esquerda e passa como primeiro argumento para a função da direita.

Como exemplo, iremos utilizar o módulo Enum que possui as funções map/2 e filter/2, onde basicamente recebem uma coleção e uma função a ser aplicadas a cada uma delas.

```
colecao = [1,2,3]
[1,2,3]

Enum.map(colecao, &(&1 * 2))
[2,4,6]

Enum.filter(colecao, &(&1 > 2))
[3]

Enum.filter(Enum.map(colecao, &(&1 * 2)), &(&1 > 4))
[6]
```

Utilizando Pipe, veja como fica mais simples:

```
Enum.map(colecao, &(&1 * 2)) |>
Enum.filter(&1 > 4) |>
```

Note que estamos passando somente a função anônima, já que o pipe automaticamente passou o retorno da função anterior como primeiro argumento.

```
Enum.map(colecao, &(&1 * 2)) |>
Enum.map.(&1 * 2) |>
Enum.map.(&1 * 2) |>
[8, 16, 24]
```

```
itens = [
    %{produto: "TV LG 32 polegadas", valor: 935.50},
    %{produto: "Notebook Samsung", valor: 1599.00},
    %{produto: "Barbeador Gillete", valor: 9.99}
]
Enum.map(itens, &(Float.round(&1.valor - &1.valor * 0.2))) |>
Enum.filter(&(&1 > 10.00)) |>
Enum.sum
2027.6
```