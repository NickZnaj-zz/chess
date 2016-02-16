require_relative 'display'



class Game
  attr_reader :display
  attr_accessor :board

  def initialize(board)
    @board = board
    board.populate(:w)
    board.populate(:b)
    @display = Display.new(board)
  end

  def play_turn
    start_pos = display.move
    end_pos = display.move
    board.move(start_pos,end_pos)
    display.move
  end




end


board = Board.new
board[[3,3]] = Queen.new(:b, board, [3,3])
game = Game.new(board)

game.play_turn
#debugger

p board[[3,3]].validate_moves.count
