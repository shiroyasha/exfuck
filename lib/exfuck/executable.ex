defmodule Exfuck.Executable do
  defstruct instructions: nil, position: 0, length: 0

  def new(source_code) do
    %Exfuck.Executable {
      :instructions => source_code,
      :length => String.length(source_code)
    }
  end

  def instruction(exe) do
    String.at(exe.instructions, exe.position)
  end

  def next(exe) do
    %{exe | :position => exe.position + 1}
  end

  def prev(exe) do
    %{exe | :position => exe.position - 1}
  end

  def valid_position?(exe) do
    exe.position < exe.length && exe.position >= 0
  end

  def loop_start(exe) do
    if instruction(exe) != "[" do
      exe |> prev |> loop_start
    else
      exe
    end
  end

  def exit_loop(exe) do
    if instruction(exe) != "]" do
      exe |> next |> exit_loop
    else
      exe
    end
  end

end
