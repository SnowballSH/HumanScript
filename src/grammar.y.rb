class Parser

token INTEGER IDEN NEWLINE DEFINE DEF END AS CLASS REP ALWAYS BREAK
      IF ELSE
      POW DBEQ NTEQ GT LT GTEQ LTEQ

prechigh
  left  '.'
  left  POW
  left  '*' '/' '%'
  left  '+' '-'
  left  DBEQ NTEQ GT LT GTEQ LTEQ
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
  | Unary
  | Comp
  | Call
  | Def
  | Get
  | Set
  | Class
  | Cond
  | Loop
  | Break
  | '(' Expression ')'          { result = val[1] }
;

Operation:
    Expression POW Expression  { result = CallNode.new(val[0], '__pow', [val[2]]) }
  | Expression '+' Expression  { result = CallNode.new(val[0], '__add', [val[2]]) }
  | Expression '-' Expression  { result = CallNode.new(val[0], '__sub', [val[2]]) }
  | Expression '*' Expression  { result = CallNode.new(val[0], '__mul', [val[2]]) }
  | Expression '/' Expression  { result = CallNode.new(val[0], '__div', [val[2]]) }
  | Expression '%' Expression  { result = CallNode.new(val[0], '__mod', [val[2]]) }
;

Unary:
    '-' Expression             { result = CallNode.new(val[1], '__neg', []) }
  | '+' Expression             { result = CallNode.new(val[1], '__pos', []) }
;

Comp:
    Expression DBEQ Expression  { result = CallNode.new(val[0], '__eq',   [val[2]]) }
  | Expression NTEQ Expression  { result = CallNode.new(val[0], '__neq',  [val[2]]) }
  | Expression GT   Expression  { result = CallNode.new(val[0], '__gt',   [val[2]]) }
  | Expression LT   Expression  { result = CallNode.new(val[0], '__lt',   [val[2]]) }
  | Expression GTEQ Expression  { result = CallNode.new(val[0], '__gteq', [val[2]]) }
  | Expression LTEQ Expression  { result = CallNode.new(val[0], '__lteq', [val[2]]) }
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
  | Terminator END                { result = Nodes.new([]) }
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
  | ParamList ',' IDEN            { result = val[0] << val[2] }
;

Cond:
    IF Expression Terminator Expressions 
    Terminator ELSE Block         { result = IfElseNode.new(val[1], val[3], val[6]) }
  | IF Expression Block           { result = IfNode.new(val[1], val[2]) }
;

Loop:
    REP Expression Block          { result = RepNode.new(val[1], val[2]) }
  | ALWAYS Block                  { result = AlwaysNode.new(val[1]) }
;

Break:
    BREAK                  { result = BreakNode.new }
;

Terminator:
    NEWLINE                { result = val[0] }
  | ';'                    { result = val[0] }
;

---- header
  require "#{File.dirname(__FILE__)}/lexer.rb"
  require "#{File.dirname(__FILE__)}/nodes.rb"

  $REF = {
    '**' => :POW,
    '==' => :DBEQ,
    '!=' => :NTEQ,
    '<=' => :LTEQ,
    '>=' => :GTEQ,
    '<'  => :LT,
    '>'  => :GT
  }

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
  