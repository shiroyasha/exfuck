defmodule ExfuckTest do
  use ExUnit.Case
  doctest Exfuck

  test "display current pointer" do
    code = "+."

    assert Exfuck.run(code) == <<1>>
  end

  test "increment" do
    code = "+."

    assert Exfuck.run(code) == <<1>>
  end

  test "decrement" do
    code = "++.-."

    assert Exfuck.run(code) == <<2, 1>>
  end

  test "movement" do
    code = "+>++<.>."

    assert Exfuck.run(code) == <<1, 2>>
  end

  test "calculating 3*3 with a loop" do
    code = "+++[>+++<-]>."

    assert Exfuck.run(code) == <<9>>
  end

  test "hello world compilation" do
    hello_world = """
      +++++ +++++             initialize counter (cell #0) to 10
      [                       use loop to set 70/100/30/10
          > +++++ ++              add  7 to cell #1
          > +++++ +++++           add 10 to cell #2
          > +++                   add  3 to cell #3
          > +                     add  1 to cell #4
      <<<< -                  decrement counter (cell #0)
      ]
      > ++ .                  print 'H'
      > + .                   print 'e'
      +++++ ++ .              print 'l'
      .                       print 'l'
      +++ .                   print 'o'
      > ++ .                  print ' '
      << +++++ +++++ +++++ .  print 'W'
      > .                     print 'o'
      +++ .                   print 'r'
      ----- - .               print 'l'
      ----- --- .             print 'd'
      > + .                   print '!'
      > .                     print '\n'
    """

    assert Exfuck.run(hello_world) == "Hello World!\n"
  end
end
