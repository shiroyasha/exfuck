defmodule Exfuck.ProgramState do
  defstruct tape: [0], tape_pointer: 0, code_pointer: 0, output: [], code: ""

  def new(code) do
    %Exfuck.ProgramState{ :code => code }
  end

  def value(state) do
    Enum.at(state.tape, state.tape_pointer)
  end

  def instruction(state) do
    String.at(state.code, state.code_pointer)
  end

  def output(state) do
    state.output |> List.to_string
  end

  def finished?(state) do
    state.code_pointer >= String.length(state.code)
  end

  def increment_code_pointer(state) do
    %{state | :code_pointer => state.code_pointer + 1}
  end

  def increment_tape_pointer(state) do
    tape = if length(state.tape) <= state.tape_pointer + 1 do
             state.tape ++ [0]
           else
             state.tape
           end

    %{state | :tape => tape, :tape_pointer => state.tape_pointer + 1}
  end

  def decrement_tape_pointer(state) do
    %{state | :tape_pointer => state.tape_pointer - 1}
  end

  def increment_value(state) do
    new_value = value(state) + 1
    new_tape = List.replace_at(state.tape, state.tape_pointer, new_value)

    %{state | :tape => new_tape}
  end

  def save(state) do
    %{state | :output => [value(state) | state.output]}
  end

end
