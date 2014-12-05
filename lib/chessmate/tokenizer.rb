module Chessmate
  module PGN
    class Tokenizer        # TODO: tweak regexes to adhere to PGN spec
      STRING               = /"(?:[^"\\]|\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4}))*"/
      SYMBOL               = /[a-zA-Z0-9]{1}[\w:\+=\-#]{0,254}/
      INTEGER              = /\d+/
      NAG                  = /\$\d+/

      def initialize io
        @ss = StringScanner.new io.read
      end

      def next_token
        return if @ss.eos?

        case
        when text = @ss.scan(STRING)  ; [:STRING,  text]
        when text = @ss.scan(SYMBOL)  ; [:SYMBOL,  text]
        when text = @ss.scan(INTEGER) ; [:INTEGER, text]
        when text = @ss.scan(NAG)     ; [:NAG,     text]
        else char = @ss.getch         ; [char,     char]
        end
      end
    end
  end
end