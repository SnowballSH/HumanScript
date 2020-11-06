require_relative './src/parser.rb'

def run(code)
  r =  Parser.new.parse(code).eval(RootContext)
end

def main
  fn = ARGV[0]
  code = File.read(fn)
  run(code)
end

main
