require_relative './src/parser.rb'

def run(code)
  r =  Parser.new.parse(code).eval
end

def main
  fn = ARGV[0]
  code = File.read(fn)
  p run(code)
end

main
