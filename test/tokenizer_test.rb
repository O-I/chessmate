require 'minitest/autorun'
require 'chessmate/tokenizer'

module Chessmate
  module PGN
    class TestTokenizer < MiniTest::Unit::TestCase

      [
        [:STRING, '"F/S Return Match"'],
        [:STRING, '"Belgrade, Serbia Yugoslavia|JUG"'],
        [:STRING, '"1992.11.04"'],
        [:STRING, '"Robert James \"Bobby\" Fischer"'],
        [:STRING, '"Ą ą Ĳ ĳ \\\\ Љ Щ щ Ӄ"'],

        [:SYMBOL, 'Event'],
        [:SYMBOL, 'WhiteElo'],
        [:SYMBOL, 'BlackType'],
        [:SYMBOL, 'FEN'],
        [:SYMBOL, 'd4'],
        [:SYMBOL, 'Nce2'],
        [:SYMBOL, 'Ra6'],
        [:SYMBOL, 'B:e5'],
        [:SYMBOL, 'Be5:'],
        [:SYMBOL, 'O-O'],
        [:SYMBOL, 'O-O-O'],
        [:SYMBOL, 'Qa6xb7#'],
        [:SYMBOL, 'fxg1=Q+'],

        [:RESULT, '1-0'],
        [:RESULT, '0-1'],
        [:RESULT, '1/2-1/2'],
        [:RESULT, '*'],

        [:MOVE, '1'],
        [:MOVE, '23'],
        [:MOVE, '5.'],
        [:MOVE, '42..'],

        [:NAG, '$1'],
        [:NAG, '$12'],
        [:NAG, '$123'],

        ['.', '.'],
        ['[', '['],
        [']', ']'],
        ['(', '('],
        [')', ')'],
        ['<', '<'],
        ['>', '>']
      ].each do |token|
        define_method("test_#{token}") do
          tok = new_tokenizer token.last
          assert_equal token, tok.next_token
        end
      end

      def new_tokenizer string
        Tokenizer.new StringIO.new string
      end
    end
  end
end