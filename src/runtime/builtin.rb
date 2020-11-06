$constants = {}
$constants['Class'] = HClass.new
$constants['Class'].runtime_class = $constants['Class']
$constants['Object'] = HClass.new

$constants['Function'] = HClass.new

$constants['Number'] = HClass.new

$constants['NilClass'] = HClass.new
$constants['nil'] = $constants['NilClass'].new_with_value(nil)

root_self = $constants['Object'].new
RootContext = Context.new(root_self)

$constants['Class'].def :new, 0 do |receiver, _arguments|
  receiver.new
end

############# Object #############

$constants['Object'].def :pln, -1 do |_receiver, arguments|
  puts(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end

$constants['Object'].def :print, -1 do |_receiver, arguments|
  print(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end

############# Object #############

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
