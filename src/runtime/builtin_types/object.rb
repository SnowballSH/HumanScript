############# Object #############
Ref = {
  true: 'happy',
  false: 'sad',
  "": 'dead'
}.freeze

$constants['Object'].def :pln, 1 do |_receiver, arguments|
  puts(*arguments.map { |x| Ref.key?(x.value.to_s.to_sym) ? Ref[x.value.to_s.to_sym] : x.value }.join(' '))
  $constants['dead']
end

$constants['Object'].def :print, 1 do |_receiver, arguments|
  print(*arguments.map { |x| Ref.key?(x.value.to_sym) ? Ref[x.to_sym] : x.value }.join(' '))
  $constants['dead']
end
