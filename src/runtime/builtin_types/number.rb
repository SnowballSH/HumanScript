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
  result = receiver.value / arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__mod, 1 do |receiver, arguments|
  result = receiver.value % arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__pow, 1 do |receiver, arguments|
  result = receiver.value**arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__neg, 0 do |receiver, _arguments|
  result = -receiver.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :__pos, 0 do |receiver, _arguments|
  result = +receiver.value
  $constants['Number'].new_with_value(result)
end

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
