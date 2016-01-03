defmodule Exfuck do

  @initial_state %{
    :tape => [0],
    :tape_pointer => 0,
    :code => "",
    :code_pointer => 0,
    :output => []
  }

  def run(code) do
    state = %{ @initial_state | :code => code }

    result_state = do_run(state)

    result_state[:output] |> List.to_string
  end

  defp do_run(state) do
    if state[:code_pointer] < String.length(state[:code]) do
      new_state = run_instruction(state, current_instruction(state))

      display_state new_state

      do_run %{new_state | :code_pointer => state[:code_pointer] + 1}
    else
      state
    end
  end

  defp current_instruction(state) do
    String.at(state[:code], state[:code_pointer])
  end

  defp current_value(state) do
    Enum.at(state[:tape], state[:tape_pointer])
  end

  defp display_state(state) do
    IO.puts "tape: #{state[:tape]}"
    IO.puts "tape_pointer: #{state[:tape_pointer]}"
    IO.puts "code: #{state[:code]}"
    IO.puts "code_pointer: #{state[:code_pointer]}"
    IO.puts "output: #{state[:output]}"
  end


  defp run_instruction(state, ".") do
    %{state | :output => state[:output] ++ [current_value(state)]}
  end

  defp run_instruction(state, "+") do
    new_tape = List.replace_at(state[:tape],
                               state[:tape_pointer],
                               current_value(state) + 1)

    %{state | :tape => new_tape}
  end

end
