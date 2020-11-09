class Parser

token INTEGER IDEN NEWLINE DEFINE DEF END AS CLASS
      IF ELSE

prechigh
  left  '.'
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
  | Operation
  | Call
  | Def
  | Get
  | Set
  | Class
  | Cond
  | '(' Expression ')'          { result = val[1] }
;

Operation:
    Expression '+'  Expression  { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '-'  Expression  { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '*'  Expression  { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '/'  Expression  { result = CallNode.new(val[0], val[1], [val[2]]) }
;

Get:
    IDEN                        { result = VarAccessNode.new(nil, val[0]) }
  | Expression "." IDEN         { result = VarAccessNode.new(val[0], val[2]) }
  | "&" IDEN                    { result = StrictVarAccessNode.new(nil, val[1]) }
  | Expression "." "&" IDEN     { result = StrictVarAccessNode.new(val[0], val[3]) }
;

Set:
    DEFINE IDEN AS Expression   { result = ConstantAssignNode.new(val[1], val[3]) }
  | IDEN '=' Expression         { result = VarAssignNode.new(val[0], val[2]) }
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

Block:
    Terminator Expressions END    { result = val[1] }
;

Def:
    DEF IDEN Block                { result = DefNode.new(val[1], [], val[2]) }
  | DEF IDEN
      "(" ParamList ")" Block     { result = DefNode.new(val[1], val[3], val[5]) }
;

Class:
    CLASS IDEN Block              { result = ClassNode.new(val[1], val[2]) }
;

ParamList:
    /* nothing */                 { result = [] }
  | IDEN                          { result = val }
  | ParamList "," IDEN            { result = val[0] << val[2] }
;

Cond:
    IF Expression Terminator Expressions 
    Terminator ELSE Block         { result = IfElseNode.new(val[1], val[3], val[6]) }
  | IF Expression Block           { result = IfNode.new(val[1], val[2]) }
;

Terminator:
    NEWLINE                { result = val[0] }
  | ';'                    { result = val[0] }
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
  