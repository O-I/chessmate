module Chessmate
  module PGN
    class Tokenizer        # TODO: tweak regexes to adhere to PGN spec
      STRING               = /"([[:print:]&&[^\\"]]|\\\\|\\")*"/
      SYMBOL               = /[a-zA-Z0-9_\w:\+=\-#]+/
      RESULT               = /(1\-0|0\-1|1\/2\-1\/2|\*)/
      MOVE_NO              = /\d+\.*/
      NAG                  = /\$\d+/
      WHITESPACE           = /\s+/

      def initialize io
        @ss = StringScanner.new io.read
      end

      def next_token
        @ss.skip(WHITESPACE)
        return if @ss.eos?

        case
        when text = @ss.scan(STRING)  ; [:STRING,  text]
        when text = @ss.scan(RESULT)  ; [:RESULT,  text]
        when text = @ss.scan(MOVE_NO) ; [:MOVE_NO, text]
        when text = @ss.scan(SYMBOL)  ; [:SYMBOL,  text]
        when text = @ss.scan(NAG)     ; [:NAG,     text]
        else char = @ss.getch         ; [char,     char]
        end
      end
    end
  end
end