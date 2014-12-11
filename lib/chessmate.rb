require_relative 'chessmate/parser'
require_relative 'chessmate/tokenizer'
require_relative 'chessmate/version'

module Chessmate
  module PGN
    class << self
      def load_io(input)
        tok     = Chessmate::PGN::Tokenizer.new input
        parser  = Chessmate::PGN::Parser.new tok
        handler = parser.parse
        handler
      end

      def load(pgn)
        load_io StringIO.new pgn
      end
    end
  end
end