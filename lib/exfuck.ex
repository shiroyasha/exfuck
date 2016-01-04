defmodule Exfuck do
  alias Exfuck.ProgramState, as: State

  def run(code) do
    code |> State.new |> do_run |> State.output
  end

  defp do_run(state) do
    if State.finished?(state) do
      state
    else
      state
      |> run_instruction(State.instruction(state))
      |> IO.inspect(width: 120)
      |> State.increment_code_pointer
      |> do_run
    end
  end

  defp run_instruction(state, ".") do
    state |> State.save
  end

  defp run_instruction(state, "+") do
    state |> State.set_value(State.value(state) + 1)
  end

  defp run_instruction(state, "-") do
    state |> State.set_value(State.value(state) - 1)
  end

  defp run_instruction(state, ">") do
    state |> State.increment_tape_pointer
  end

  defp run_instruction(state, "<") do
    state |> State.decrement_tape_pointer
  end

  defp run_instruction(state, "[") do
    if State.value(state) == 0 do
      move_to_closing_bracket(state)
    else
      state
    end
  end

  defp run_instruction(state, "]") do
    if State.value(state) != 0 do
      move_to_opening_bracket(state)
    else
      state
    end
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
