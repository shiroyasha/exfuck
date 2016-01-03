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
      |> State.display
      |> State.increment_code_pointer
      |> do_run
    end
  end

  defp run_instruction(state, ".") do
    state |> State.save
  end

  defp run_instruction(state, "+") do
    state |> State.increment_value
  end

end
