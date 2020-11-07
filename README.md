# HumanScript Programming Language

## A language for machine, programmers, and everyone.

Example:

```lua
-- Comment
--[
  Multi
  Line
  Comment
]

-- Define Methods
def a
  pln(3)  -- Stands for "PrintLine"
end
def b(x, y)
  pln(x + y, x - y, x * y, x / y)
end

-- Define Class
class Alpha
  def addpln(x, y)
    pln(x + y)
  end
end

-- Define variables
define ZERO as 0
define THREE as 3
TEN = 10

a  -- 3
b(3, 4)  -- 7 -1 12 0

pln(ZERO.nonz)  -- 0
pln(THREE.nonz)  -- 1
pln(TEN.nonz)  -- 1

pln(a)   -- nil
pln(&a)  --[ Displays value instead of calling it
              Something like #<HMethod:0x0000000006465e78> ]

alpha = Alpha.new   -- Create instance of Alpha
alpha.addpln(3, 8)  -- 11

--[
  Result:
    3
    7 -1 12 0
    0
    1
    1
    3

    #<HMethod:0x0000000006465e78>
    11
]
```
