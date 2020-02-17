defmodule Calculator do
  @moduledoc """
  Define a Calculator module and functions to execute it.
  """

  @doc """
  Start the system to process some result.
  """
  def start() do
    joao = %Student{name: "João Joaquim", result: build_subjects([5.2, 3.9, 2.7, 9.8])}
    maria = %Student{name: "Maria da Silva", result: build_subjects([8.4, 7.5, 9.4, 2.8])}
    pedro = %Student{name: "Pedro Pedrada", result: build_subjects([1.3, 8.5, 8.9, 7.6])}
    kaua = %Student{name: "Kauã Camboinhas", result: build_subjects([5.4, 4.9, 2.2, 3.8])}

    result = calculate([joao, maria, pedro, kaua])
    best = best_result(result)

    {result, best}
  end

  @doc """
  Get all students and their averages.
  """
  defp calculate(students) do
    students
    |> Enum.map(
      &%{
        first_name: Student.first_name(&1),
        last_name: Student.last_name(&1),
        average: average(&1)
      }
    )
  end

  @doc """
  Calculate the average of a Student.
  """
  defp average(student) do
    total = Enum.count(student.results)

    result =
      student.results
      |> Enum.map(& &1.result)
      |> Enum.reduce(&(&1 + &2))

    Float.ceil(result / total, 2)
  end

  @doc """
  Get the greater average
  """
  defp best_result(students) do
    best =
      students
      |> Enum.map(& &1.average)
      |> Enum.max()

    students
    |> Enum.filter(&(&1.average === best))
  end

  @doc """
  Build some subjects and some random results.
  """
  defp build_subjects(results) do
    subjects = ["Matemática", "Português", "Geografia", "História"]

    subjects
    |> Enum.map(&%Subect{name: &1, result: Enum.random(results)})
  end
end