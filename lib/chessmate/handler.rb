module Chessmate
  module PGN
    class Handler
      attr_accessor :tag_pairs, :movetext

      def initialize
        @tag_pairs = {}
        @movetext  = []
      end
    end
  end
end