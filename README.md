# Exfuck

Brainfuck interpreter written in Elixir.

![Exfuck logo](https://raw.githubusercontent.com/shiroyasha/exfuck/master/logo.jpg)



## Installation

The package is available on hex, and can be installed with:

```
def deps do
  [{:exfuck, "~> 0.1.0"}]
end
```

## Usage

To run a Branfuck program you can use the `run` method. For example to run a
snippet that returns 'Hello World', do the following:

``` elixir
code = """
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

Exfuck.run(code) # => "Hello World!"
```

## License

The MIT License (MIT)

Copyright (c) 2016 Igor Šarčević

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
