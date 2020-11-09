############# Object #############

$constants['Object'].def :pln, 1 do |_receiver, arguments|
  puts(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end

$constants['Object'].def :print, 1 do |_receiver, arguments|
  print(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end

$constants['Object'].def :nonz, 0 do |_receiver, _arguments|
  $constants['Number'].new_with_value(0)
end
