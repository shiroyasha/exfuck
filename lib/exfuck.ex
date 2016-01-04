defmodule Exfuck do
  alias Exfuck.ProgramState, as: State
  alias Exfuck.Tape, as: Tape

  def run(code) do
    code |> State.new |> do_run |> State.output
  end

  defp do_run(state) do
    if State.finished?(state) do
      state
    else
      state
      |> run_instruction(State.instruction(state))
      # |> IO.inspect(width: 120)
      |> State.increment_code_pointer
      |> do_run
    end
  end

  defp run_instruction(state, ".") do
    state |> State.save
  end

  defp run_instruction(state, "+") do
    %{state | :tape => Tape.increment(state.tape)}
  end

  defp run_instruction(state, "-") do
    %{state | :tape => Tape.decrement(state.tape)}
  end

  defp run_instruction(state, ">") do
    %{state | :tape => Tape.move_right(state.tape)}
  end

  defp run_instruction(state, "<") do
    %{state | :tape => Tape.move_left(state.tape)}
  end

  defp run_instruction(state, "[") do
    if Tape.zero?(state.tape) do
      move_to_closing_bracket(state)
    else
      state
    end
  end

  defp run_instruction(state, "]") do
    if Tape.zero?(state.tape) do
      state
    else
      move_to_opening_bracket(state)
    end
  end

  defp run_instruction(state, _) do
    state # do nothing
  end

  defp move_to_closing_bracket(state) do
    if State.instruction(state) != "]" do
      state
      |> State.increment_code_pointer
      |> move_to_closing_bracket
    else
      state
    end
  end

  defp move_to_opening_bracket(state) do
    if State.instruction(state) != "[" do
      state
      |> State.decrement_code_pointer
      |> move_to_opening_bracket
    else
      state
    end
  end

end
