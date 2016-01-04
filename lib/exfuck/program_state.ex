defmodule Exfuck.ProgramState do
  alias Exfuck.Tape, as: Tape
  alias Exfuck.Executable, as: Exe

  defstruct tape: Tape.new, executable: nil, output: []

  def new(source) do
    %Exfuck.ProgramState{ :executable => Exe.new(source) }
  end

  def output(state) do
    state.output |> List.to_string
  end

  def run(state) do
    if Exe.valid_position?(state.executable) do
      state
      |> run_instruction(Exe.instruction(state.executable))
      #|> IO.inspect(width: 120)
      |> next_instruction
      |> run
    else
      state
    end
  end

  def next_instruction(state) do
    %{ state | :executable => Exe.next(state.executable) } |> run
  end

  def run_instruction(state, ".") do
    %{state | :output => state.output ++ [Tape.read(state.tape)]}
  end

  def run_instruction(state, "+") do
    %{state | :tape => Tape.increment(state.tape)}
  end

  def run_instruction(state, "-") do
    %{state | :tape => Tape.decrement(state.tape)}
  end

  def run_instruction(state, ">") do
    %{state | :tape => Tape.move_right(state.tape)}
  end

  def run_instruction(state, "<") do
    %{state | :tape => Tape.move_left(state.tape)}
  end

  def run_instruction(state, "[") do
    if Tape.zero?(state.tape) do
      %{state | :executable => Exe.exit_loop(state.executable)}
    else
      state
    end
  end

  def run_instruction(state, "]") do
    if Tape.zero?(state.tape) do
      state
    else
      %{state | :executable => Exe.loop_start(state.executable)}
    end
  end

  def run_instruction(state, _) do
    state # do nothing
  end

end
