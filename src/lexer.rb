#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.7
# from lexical definition file "./src/lexer.l.rb".
#++

require 'racc/parser'
class Lexer < Racc::Parser
      require 'strscan'

      class ScanError < StandardError ; end

      attr_reader   :lineno
      attr_reader   :filename
      attr_accessor :state

      def scan_setup(str)
        @ss = StringScanner.new(str)
        @lineno =  1
        @state  = nil
      end

      def action
        yield
      end

      def scan_str(str)
        scan_setup(str)
        do_parse
      end
      alias :scan :scan_str

      def load_file( filename )
        @filename = filename
        File.open(filename, "r") do |f|
          scan_setup(f.read)
        end
      end

      def scan_file( filename )
        load_file(filename)
        do_parse
      end


        def next_token
          return if @ss.eos?

          # skips empty actions
          until token = _next_token or @ss.eos?; end
          token
        end

        def _next_token
          text = @ss.peek(1)
          @lineno  +=  1  if text == "\n"
          token = case @state
            when nil
          case
                  when (text = @ss.scan(/[ \t\b]+/))
                    ;

                  when (text = @ss.scan(/--\[(?:[^\]\]]|)*\]/))
                    ;

                  when (text = @ss.scan(/--.*/))
                    ;

                  when (text = @ss.scan(/[\r\n]+/))
                     action { [:NEWLINE, text] }

                  when (text = @ss.scan(/define|as|def|end|class|if|else|rep|always|rest/))
                     action { [text.upcase.to_sym, text.chomp] }

                  when (text = @ss.scan(/[\d]+/))
                     action { [:INTEGER, text.to_i] }

                  when (text = @ss.scan(/"([^"\n\r]|\")*"/))
                     action { [:STRING, text.chomp[1...-1]] }

                  when (text = @ss.scan(/[a-zA-Z_][\w]*/))
                     action { [:IDEN, text.chomp] }

                  when (text = @ss.scan(/\*\*|==|\!=|>=|<=|>|</))
                     action { [$REF[text], text] }

                  when (text = @ss.scan(/./))
                     action { [text, text] }

          
          else
            text = @ss.string[@ss.pos .. -1]
            raise  ScanError, "can not match: '" + text + "'"
          end  # if

        else
          raise  ScanError, "undefined state: '" + state.to_s + "'"
        end  # case state
          token
        end  # def _next_token

  def tokenize(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end
end # class
