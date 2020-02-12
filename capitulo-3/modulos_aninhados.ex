# módulo aninhado
defmodule Multiplicador do
  defmodule Multiplique do
    def por_dois(numero) do
      numero * 2
    end
  end
end

# aninhado com ponto
defmodule Multiplicador.Multiplique do
  def por_dois(numero) do
    numero * 2
  end
end
