defmodule Student do
  @moduledoc """
  Define a Student struct and function to handle a student.
  """

  @doc """
  Get the first name of a Student.
  """
  def first_name(student) do
    student.name
    |> String.split()
    |> List.first()
  end

  @doc """
  Get the last name of a Student.
  """
  def last_name(student) do
    student.name
    |> String.split()
    |> List.last()
  end
end
