class Lexer
macro
  BLANK         [\ \t\b]+
  NEWLINE       [\r\n]+
  LONGCOMMENT   --\[(?:[^\]\]]|)*\]
  SHORTCOMMENT  --.*

  KEYWORD       define|as|def|end|class|if|else|rep|always|rest
  OP            \*\*|==|\!=|>=|<=|>|<
  
  IDEN          [a-zA-Z_][\w]*
  NUM           [\d]+

rule
  {BLANK}       # no action
  {LONGCOMMENT}
  {SHORTCOMMENT}
  {NEWLINE}     { [:NEWLINE, text] }
  {KEYWORD}     { [text.upcase.to_sym, text.chomp] }
  {NUM}         { [:INTEGER, text.to_i] }
  {IDEN}        { [:IDEN, text.chomp] }
  {OP}          { [$REF[text], text] }
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
