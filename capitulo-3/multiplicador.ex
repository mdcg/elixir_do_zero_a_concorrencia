# Exemplo de módulo
defmodule Multiplicador do
  def multiplique(a, b) do
    a * b
  end

  # Declarações com apenas uma linha
  def subtraia(a, b \\ 2), do a - b

  # Funções privadas
  defp divide(a, b), do div(a, b)
end