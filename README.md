# HumanScript Programming Language

## A language for machine, programmers, and everyone.

#### Everything in this language are things a human would do! (Always, Rest, Rep, Happy, Sad, Dead, etc.)

### See the Easy Syntax and Language tour [here](https://github.com/SnowballSH/HumanScript/blob/master/Ref.md)

#### You can try out the language on [This repl.it link](https://repl.it/@SnowballSH/HumanScript)

## Sample code (nth Fibonacci)

```ruby
def fib(n)
  a = 0; b = 1

  if n < 0
    pln("bad input")
  else
    if n <= 1
      pln(n)
    else
      rep n - 1
        c = a + b
        a = b
        b = c
      end
      pln(b)
    end
  end
end

fib(0)    -- 0
fib(1)    -- 1
fib(9)    -- 34
fib(999)  --[
  2686381002448535938614672720214292396761660931898695234012
  3175997617981700247881689338369654483356564191827856161443
  3563129766736422103503246348504103776803673341511728991697
  23197082763985615764450078474174626
]
```
