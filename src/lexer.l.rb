class Lexer
macro
  BLANK         [\ \t\b]+
  NEWLINE       [\r\n]+
  IDEN          [a-z][\w]*
  NUM           [\d]+

rule
  {BLANK}       # no action
  {NEWLINE}     { [:NEWLINE, text] }
  {NUM}         { [:INTEGER, text.to_i] }
  {IDEN}        { [:IDEN, text.chomp] }
  \/            { [:INDEX, text] }
  .             { [text, text] }

inner
  def tokenize(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end
end
