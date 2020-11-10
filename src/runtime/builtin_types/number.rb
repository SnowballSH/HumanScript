############# Number #############

$constants['Number'].def :__add, 1 do |receiver, arguments|
  result = receiver.value + arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__sub, 1 do |receiver, arguments|
  result = receiver.value - arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__mul, 1 do |receiver, arguments|
  result = receiver.value * arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__div, 1 do |receiver, arguments|
  v = arguments.first.value
  if receiver.value == 0 && v == 0
    $constants['nan']
  elsif v == 0
    $constants['infinity']
  else
    result = receiver.value / v
    $constants['Number'].new_with_value(result)
  end
end

$constants['Number'].def :__mod, 1 do |receiver, arguments|
  v = arguments.first.value
  if receiver.value == v && v == 0
    $constants['nan']
  elsif v == 0
    $constants['infinity']
  else
    result = receiver.value % v
    $constants['Number'].new_with_value(result)
  end
end

$constants['Number'].def :__pow, 1 do |receiver, arguments|
  result = receiver.value**arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :sqrt, 0 do |receiver, _arguments|
  v = receiver.value
  if v < 0
    $constants['infinity']
  else
    result = Integer.sqrt(v)
    $constants['Number'].new_with_value(result)
  end
end

$constants['Number'].def :__neg, 0 do |receiver, _arguments|
  result = -receiver.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__pos, 0 do |receiver, _arguments|
  result = +receiver.value
  $constants['Number'].new_with_value(result)
end

## Booleans ##

$constants['Number'].def :__eq, 1 do |receiver, arguments|
  result = receiver.value == arguments.first.value
  $constants['Bool'].new_with_value(result)
end

$constants['Number'].def :__neq, 1 do |receiver, arguments|
  result = receiver.value != arguments.first.value
  $constants['Bool'].new_with_value(result)
end

$constants['Number'].def :__gt, 1 do |receiver, arguments|
  result = receiver.value > arguments.first.value
  $constants['Bool'].new_with_value(result)
end

$constants['Number'].def :__lt, 1 do |receiver, arguments|
  result = receiver.value < arguments.first.value
  $constants['Bool'].new_with_value(result)
end

$constants['Number'].def :__gteq, 1 do |receiver, arguments|
  result = receiver.value >= arguments.first.value
  $constants['Bool'].new_with_value(result)
end

$constants['Number'].def :__lteq, 1 do |receiver, arguments|
  result = receiver.value <= arguments.first.value
  $constants['Bool'].new_with_value(result)
end
