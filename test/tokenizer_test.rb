require 'json'
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
        [:STRING, '"Ą ą Ĳ ĳ \\\\ Љ Щ щ Ӄ"']
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