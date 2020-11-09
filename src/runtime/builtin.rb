$constants = {}
$constants['Class'] = HClass.new(nil, 'Class')
$constants['Class'].runtime_class = $constants['Class']
$constants['Object'] = HClass.new(nil, 'Object')

$constants['Function'] = HClass.new($constants['Object'], 'Function')

$constants['Number'] = HClass.new($constants['Object'], 'Number')
$constants['Bool'] = HClass.new($constants['Object'], 'Bool')
$constants['true'] = $constants['Bool'].new_with_value(true)
$constants['false'] = $constants['Bool'].new_with_value(false)

$constants['NilClass'] = HClass.new($constants['Object'], 'Nil')
$constants['nil'] = $constants['NilClass'].new_with_value(nil)

root_self = $constants['Object'].new
RootContext = Context.new(root_self)

$constants['Class'].def :new, 0 do |receiver, _arguments|
  receiver.new
end

require_relative './builtin_types/object'

require_relative './builtin_types/number'
require_relative './builtin_types/bool'
