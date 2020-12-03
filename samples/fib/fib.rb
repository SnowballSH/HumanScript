def fib(n)
  a = 0
  b = 1
  if n < 0
    puts('bad input')
  elsif n <= 1
    puts n
  else
    (n - 1).times do
      c = a + b
      a = b
      b = c
    end
    puts b
  end
end

fib 0
fib 1
fib 9
fib 999
fib 123_456
