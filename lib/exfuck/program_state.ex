defmodule Exfuck.ProgramState do
  alias Exfuck.Tape, as: Tape

  defstruct tape: Tape.new, code_pointer: 0, code: "", output: []

  def new(code) do
    %Exfuck.ProgramState{ :code => code }
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

  def decrement_code_pointer(state) do
    %{state | :code_pointer => state.code_pointer - 1}
  end

  def save(state) do
    %{state | :output => state.output ++ [Tape.read(state.tape)]}
  end

end
