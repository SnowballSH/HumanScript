############# Object #############

$constants['Object'].def :pln, -1 do |_receiver, arguments|
  puts(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end

$constants['Object'].def :print, -1 do |_receiver, arguments|
  print(*arguments.map { |x| x.value }.join(' '))
  $constants['nil']
end
