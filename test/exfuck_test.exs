defmodule ExfuckTest do
  use ExUnit.Case
  doctest Exfuck

  test "display current pointer" do
    code = "."

    assert Exfuck.run(code) == "0"
  end

  test "simple increment" do
    code = "+++."

    assert Exfuck.run(code) == "3"
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

    assert Exfuck.run(hello_world) == "Hello world!\n"
  end
end
