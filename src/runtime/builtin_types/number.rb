############# Number #############

$constants['Number'].def :+, 1 do |receiver, arguments|
  result = receiver.value + arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :-, 1 do |receiver, arguments|
  result = receiver.value - arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :*, 1 do |receiver, arguments|
  result = receiver.value * arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :/, 1 do |receiver, arguments|
  result = receiver.value / arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :pow, 1 do |receiver, arguments|
  result = receiver.value**arguments.first.value
  $constants['Number'].new_with_value(result)
end

$constants['Number'].def :nonz, 0 do |receiver, _arguments|
  result = receiver.value != 0 ? 1 : 0
  $constants['Number'].new_with_value(result)
end
