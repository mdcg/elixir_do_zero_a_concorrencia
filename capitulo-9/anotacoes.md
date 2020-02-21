# Introdução a processos

Processos em Elixir são abstrações autocontidas (São únicos e isolados). As implementações de controle de estado dentro de cada processo permanecem lá e nada fica exposto, mesmo quando esses processos são executados ao mesmo tempo ou em diferentes máquinas.

O contexto de cada processo é 100% isolado de outros processos, eles só podem se comunicar através de `mensagens`.

Só para deixar claro, os processos que rodam na máquina virtual do Erlang não estão relacionados aos processos que são geridos pelo Sistema Operacional.

Os processos da máquina virtual do Erlang são geridos internamente pela própria máquina. São leves, fáceis de controlar, isolados, se comunicam entre si e não é incomum rodarmos milhares deles ao mesmo tempo em apenas uma máquina virtual. Não custa caro levantar processos dentro da VM.

Para podermos criar processos, a maneira mais simples é usando a função `spawn`. Esta tem duas versões, que são a `spawn/1` e `spawn/3`.

A `spawn/1` recebe apenas um argumento, que é uma função a ser executada dentro do processo. Seu retorno é o PID do processo.

Já a `spawn/3` é um pouco mais sofisticada, e pode receber um módulo, um atom que represente uma função dentro do módulo e uma lista de argumentos que essa função pode receber. Analogamente ao `spawn/1` ele também retorna o PID do processo.

Para ler a documentação de ambos, basta digitar `h spawn/1` e `h spawn/3`. Lá terá alguns exemplos de uso deles.

Simplificando de maneira geral, ambos criam um processo, contudo, a diferença entre as duas é que a função do `spawn/3` está dentro de um módulo que devemos especificar, juntamente com os argumentos (caso a função tenha).

Dentro do contexto do Iex, temos um processo que cuida dele, este por sua vez pode ser chamado atráves do `self()`.

Quando utilizamos o `spawn`, estamos basicamente criando outro processo isolado, mas que pode conversar com o processo do Iex através de mensagens. Sempre que precisarmos criar processos para isolar estado, ou executar funcionalidades em parelelo, estas funções são bem úteis.

A função `send` pode enviar um mensagem para outro processo. Já a macro `receive` espere casar um padrão de resposta para processar uma possível mensagem recebida.

```
pid_do_iex = self()

pid_do_processo = spawn fn -> send pid_do_iex, {self(), "Este é outro processo, veja como o PID muda"} end

receive do {pid_do_processo, mensagem} -> IO.puts "#{mensagem}" end
```

Para entender melhor como tudo funciona, nesse diretório teremos um projeto chamado "Ping Pong", de forma que quando enviarmos ping para o processo pong, ele tem que responder pong. Analogamente para o ping, quando enviarmos mensagem pra ele, o mesmo deve responder ping.

