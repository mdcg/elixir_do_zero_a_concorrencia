# Programação Concorrente e Paralela

A alta capacidade de processamento em paralelo é um dos principais problemas que a maioria das linguagens de programação tentam resolver. Na maioria dos casos, não é possível lidar com isso de maneira adequada ou gerir a programação paralela de forma a utilizar todos os cores disponíveis.

Elixir nos ajuda a resolver esse problema, já que opera sobre uma máquina virtual naturalmente projetada para resolver esse tipo de problema.

Execução paralela e concorrente são um pouquinho diferentes. Paralelismo significa que duas ou mais tarefas são livres para executar ao mesmo tempo. Também não há necessidade de interromper nenhuma delas para que outras possam prosseguir (a não ser que seja feito de forma intencional). Já a concorrência, é quando duas ou mais tarefas também parecem estar sendo executadas ao mesmo tempo, mas o processador poderia estar rapidamente trocando o foco entre elas, interrompendo uma para que possa executar a outra. Essa troca acontece tão rápido que parece que tudo está sendo executado ao mesmo tempo.

Um processador de um núcleo lida bem com problemas de concorrência, já que tem que trocar o foco das tarefas, armazenando uma em cache e executando a outra, e assim por diante.

Quando adicionamos mais núcleos, estamos aptos a executar processos em paralelo. Mas ainda assim, ele poderá continuar executando todas as tarefas concorrentemente, caso os núcleos extras não forem usados.

Para esse exemplo, iremos criar um app de previsão de tempo que será feito em duas etapas: A primeira, `sem processos em paralelo` para que possamos demonstrar o problema que isso trás; a segunda, faremos uma refatoração para a executar a mesma aplicação `em paralelo`.