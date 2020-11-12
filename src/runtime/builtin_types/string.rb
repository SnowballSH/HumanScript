############# String #############

$constants['String'].def :__add, 1 do |receiver, arguments|
  result = receiver.value + arguments.first.value
  $constants['String'].new_with_value(result)
end

$constants['String'].def :trim, 0 do |receiver, _arguments|
  result = receiver.value.strip
  $constants['String'].new_with_value(result)
end
