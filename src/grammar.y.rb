class Parser

token INTEGER IDEN NEWLINE DEFINE AS

prechigh
  left  '.'
  right '!'
  left  '*' '/'
  left  '+' '-'
  right '=' AS
  left  ','
preclow

rule

Program:
  /* nothing */          { result = Nodes.new([]) }
  | Expressions          { result = val[0] }
;

Expressions:
    Expression                          { result = Nodes.new(val) }
  | Expressions Terminator Expression   { result = val[0] << val[2] }
  | Expressions Terminator              { result = val[0] }
  | Terminator                          { result = Nodes.new([]) }
  | NEWLINE Expression                  { result = Nodes.new([val[1]]) }
;

Expression:
    INTEGER                     { result = IntegerNode.new(val[0].to_i) }
  | Call
  | Get
  | DEFINE IDEN AS Expression   { result = VarAssignNode.new(val[1], val[3]) }
  | '(' Expression ')'          { result = val[1] }
;

Get:
    IDEN                        { result = VarAccessNode.new(nil, val[0]) }
  | Expression "." IDEN         { result = VarAccessNode.new(val[0], val[2]) }
;

Call:
    IDEN Arguments          { result = CallNode.new(nil, val[0], val[1]) }
  | Expression "." IDEN
    Arguments               { result = CallNode.new(val[0], val[2], val[3]) }
;

Arguments:
    "(" ")"                       { result = [] }
  | "(" ArgList ")"               { result = val[1] }
;

ArgList:
    Expression                    { result = val }
  | ArgList "," Expression        { result = val[0] << val[2] }
;

Terminator:
  NEWLINE                { result = val[0] }
;

---- header
  require "#{File.dirname(__FILE__)}/lexer.rb"
  require "#{File.dirname(__FILE__)}/nodes.rb"

---- inner
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.tokenize(code)
    puts @tokens.inspect if show_tokens
    do_parse
  end
  
  def next_token
    @tokens.shift
  end

  def on_error(*e)
    x = e[1] == '$' ? 'End of file' : e[1]
    puts "Invalid Syntax: '#{x}'"
    exit
  end
  