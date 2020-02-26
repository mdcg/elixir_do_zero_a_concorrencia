# Tasks

Em Elixir existem diversas abstrações úteis para gerir processos que visam facilitar ainda mais a vida do desenvolvedor. Uma delas é o módulo `Task` que simplifica e muito os atos de criar, executar e capturar a resposta de um processo.

Criar um processo utilizando Task é bastante simples. Primeiro você utiliza o `Task.async` para criar uma Task. Ela recebe como argumento uma função que retorna alguma coisa. Ao fazer isso, você já criou um processo para essa função sem ter que utilizar `Spawn` nem `Receive`.

Depois, basta executar `Async.await` passando a Task que você acabou de criar para pegar a resposta do processo, que no caso, é a resposta da função que estava encapsulada em um processo.

```
task = Task.async(fn -> {:ok, "Elixir"} end)

Task.async(task)
{:ok, "Elixir"}
```

Recriamos o exemplo do capítulo anterior para utilizarmos o módulo Task! Veja acessando `aap/lib/weather.ex`.