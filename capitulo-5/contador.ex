defmodule Contador do
    def contar([]), do: 0
    def contar([head | tail]), do: 2 + contar(tail)
end