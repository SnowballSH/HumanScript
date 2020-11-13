############# Object #############
Ref = {
  true: 'happy',
  false: 'sad',
  "": 'dead'
}.freeze

def refer(x)
  Ref.key?(x.value.to_s.to_sym) ? Ref[x.value.to_s.to_sym] : x.value
end

$constants['Object'].def :pln, 1 do |_receiver, arguments|
  puts(*arguments.map { |x| refer(x) }.join(' '))
  $constants['dead']
end

$constants['Object'].def :print, 1 do |_receiver, arguments|
  print(*arguments.map { |x| refer(x) }.join(' '))
  $constants['dead']
end
