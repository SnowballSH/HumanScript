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

$constants['Class'].def :new do |receiver, _arguments|
  receiver.new
end

$constants['Object'].def :print do |_receiver, arguments|
  puts arguments.first.value
  $constants['nil']
end
