defmodule Exfuck do
  alias Exfuck.ProgramState, as: State
  alias Exfuck.Tape, as: Tape
  alias Exfuck.Executable, as: Exe

  def run(source_code) do
    source_code |> State.new |> State.run |> State.output
  end

end
