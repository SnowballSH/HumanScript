# HumanScript Programming Language

## A language for machine, programmers, and everyone.

## You can try out the language on [This repl.it link](https://repl.it/@SnowballSH/HumanScript)

## Reference Doc:

---

### Syntax

#### Variable Assignment

##### Constant assignment

`define <IDENTIFIER> as <Expression>`

```py
define FIVE as 5
```

##### Dynamic local assignment

`<IDENTIFIER> = <Expression>`

```py
hello = "Hello!"
```

##### Get the variable

`<IDENTIFIER>`

`<Expression>.<IDENTIFIER>`

_calls if it is callable, returns value elsewise_

`&<IDENTIFIER>`

`&<Expression>.<IDENTIFIER>`

_always returns value_

```py
hello
>>> Hello!
```

#### Function

##### Create function

```ruby
def <IDENTIFIER>
  <Block>
end
def <IDENTIFIER> (<Parameters>)
  <Block>
end
```

```ruby
def no_param
  pln("no param!")
end

def yes_param(a, b)
  pln(a + b)
end
```

##### Calling function

`<IDENTIFIER>`

`<Expression>.<IDENTIFIER>`

_calls if it is callable, returns value elsewise_

`<IDENTIFIER>(<Arguments>)`

`<Expression>.<IDENTIFIER>(<Arguments>)`

_panics if is not callable_

```python
no_param
>>> no param!
yes_param(2, 5)
>>> 7
```

#### Control Flow

##### Condition

```ruby
if <Expression>
  <Block>  # If Expression is not sad or dead
end

if <Expression>
  <Block>  # If Expression is not sad or dead
else
  <Block>  # Else do
end
```

##### Loops

```ruby
always  # Always run the block
  <Block>
  (optional) rest  # Breaks out the loop
end

rep <Expression>  # Runs the block this times
  <Block>
  (optional) rest  # Breaks out the loop
end
```

**If the Expression in 'rep' is not an Integer (Integer excludes NaN and Infinity), it doesn't run the Block**

#### Classes

#### **WARNING: badly implemented**

##### Define a class

```ruby
class <IDENTIFIER>
  <Block>
end
```

##### Creates a class instance

```ruby
<IDENTIFIER>.new  # The Class.new() function handles instance creation
<IDENTIFIER>.new()
```

---

### Built-in Methods

##### pln(\*args) -> dead

prints the arguments, separated using space to the console, **with** a new line.

##### print(\*args) -> dead

prints the arguments, separated using space to the console, **without** a new line.

---

### Class 'Number'

#### instances:

##### infinity

```python
infinity
>>> Infinity
```

##### nan

```python
nan
>>> NaN
```

#### class methods:

#### Number + Number -> Number

_Same as Number.\_\_add(Number)_

returns the sum of two numbers

#### Number - Number -> Number

_Same as Number.\_\_sub(Number)_

returns the difference of two numbers

#### Number \* Number -> Number

_Same as Number.\_\_mul(Number)_

returns the product of two numbers

#### Number / Number -> Number | infinity

_Same as Number.\_\_div(Number)_

returns the division result of two numbers (floored)

_returns `infinity` when attempting to divide by 0_

#### Number % Number -> Number | infinity

_Same as Number.\_\_mod(Number)_

returns the modulos result of two numbers

_returns `infinity` when attempting to mod by 0_

#### Number \*\* Number -> Number

_Same as Number.\_\_pow(Number)_

returns Number 1 to the power of Number 2

#### Number.sqrt() -> Number | infinity

returns the square root of the receiver

#### Number == Number -> Emotion

_Same as Number.\_\_eq(Number)_

returns Number == Number 2

#### Number != Number -> Emotion

_Same as Number.\_\_neq(Number)_

returns Number != Number 2

#### Number > Number -> Emotion

_Same as Number.\_\_gt(Number)_

returns Number > Number 2

#### Number < Number -> Emotion

_Same as Number.\_\_lt(Number)_

returns Number < Number 2

#### Number >= Number -> Emotion

_Same as Number.\_\_gteq(Number)_

returns Number >= Number 2

#### Number <= Number -> Emotion

_Same as Number.\_\_lteq(Number)_

returns Number <= Number 2

---
