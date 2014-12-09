class Chessmate::PGN::Parser
token STRING SYMBOL RESULT MOVE NAG
rule
  pgn_database
    : pgn_database pgn_game
    | pgn_game
    ;
  pgn_game
    : tag_pairs movetext
    ;
  tag_pairs
    : tag_pairs tag_pair
    | tag_pair
    ;
  tag_pair
    : '[' tag_name tag_value ']'
    ;
  tag_name
    : SYMBOL { puts val[0].capitalize }
    ;
  tag_value
    : STRING { puts val[0][1..-2] }
    ;
  movetext
    : moves game_termination
    ;
  moves
    : moves move
    | move
    ;
  move
    : MOVE turns
    ;
  turns
    : turns turn
    | turn
    ;
  turn
    : SYMBOL { puts val[0] }
    ;
  game_termination
    : RESULT { puts val[0] }
    ;
end

---- inner

  require_relative 'handler'

  attr_reader :handler

  def initialize(tokenizer, handler = Handler.new)
    @tokenizer = tokenizer
    @handler   = handler
    super()
  end

  def next_token
    @tokenizer.next_token
  end

  def parse
    do_parse
    handler
  end