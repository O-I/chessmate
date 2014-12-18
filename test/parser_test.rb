require 'minitest/autorun'
require 'chessmate/parser'
require 'chessmate/tokenizer'

module Chessmate
  module PGN
    class TestParser < MiniTest::Test

      def test_pgn_parsing
        file = '[Tag_Name "tag value"] 1. e4 h5 2. d4 1-0'
        parser = new_parser file
        pgn = parser.parse
        assert_equal pgn.tag_pairs, { tag_name: 'tag value' }
        assert_equal pgn.movetext,  ['e4', 'h5', 'd4']
      end

      def new_parser string
        tokenizer = Tokenizer.new StringIO.new string
        Parser.new tokenizer
      end
    end
  end
end