defmodule App.Calculator do
  def multiply(a, b) do
    cond do
      is_nil(a) || is_nil(b) -> is_nil
      true -> a * b
    end
  end
end
