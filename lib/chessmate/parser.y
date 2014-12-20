class Chessmate::PGN::Parser
token STRING SYMBOL RESULT MOVE_NO NAG
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
    : '[' tag_name tag_value ']' { @handler.tag_pairs[val[1].downcase.to_sym] = val[2][1..-2] }
    ;
  tag_name
    : SYMBOL
    ;
  tag_value
    : STRING
    ;
  movetext
    : moves game_termination
    ;
  moves
    : moves move
    | move
    ;
  move
    : MOVE_NO turns
    ;
  turns
    : turns turn
    | turn
    ;
  turn
    : SYMBOL { @handler.movetext << val[0] }
    ;
  game_termination
    : RESULT
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