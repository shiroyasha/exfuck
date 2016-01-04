defmodule Exfuck.Tape do
  defstruct array: [0], position: 0

  def new do
    %Exfuck.Tape{}
  end

  def read(tape) do
    Enum.at(tape.array, tape.position)
  end

  def zero?(tape) do
    read(tape) == 0
  end

  def increment(tape) do
    write(tape, read(tape) + 1)
  end

  def decrement(tape) do
    write(tape, read(tape) - 1)
  end

  def write(tape, value) do
    %{tape | :array => List.replace_at(tape.array, tape.position, value)}
  end

  def move_left(tape) do
    %{tape | :position => tape.position - 1}
  end

  def move_right(tape) do
    %{tape | :position => tape.position + 1} |> adjust_tape_size
  end

  defp adjust_tape_size(tape) do
    if short_tape?(tape) do
      %{tape | :array => tape.array ++ [0] } |> adjust_tape_size
    else
      tape
    end
  end

  defp short_tape?(tape) do
    length(tape.array) <= tape.position
  end

end
