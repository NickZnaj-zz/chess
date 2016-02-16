require 'byebug'

class Piece
  attr_accessor :board
  attr_reader :color

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves
    raise NotImplementedError.new("wrong method implemented.")
  end

  def present?
   true
 end

 def to_s
   " #{symbol} "
 end



end

###########################################################
###########################################################


class Sliding_pieces < Piece

  def valid_move?(pos)
    x, y = pos
    valid = true

    until valid = false
      if @board[pos].is_a?(NullPiece)
        valid = true
      elsif @board[pos].is_a?(Piece) && @board[pos].color != self.color
        valid = false
      elsif @baord[pos].is_a?(Piece) && @board[pos].color == self.color
        valid = false
      end
    end
  end



  def all_moves_in_directions

    def valid_moves
      moves.each do |each_move|


    end
    # directions = move_directions #=> [[0,1],[1,0],[-1,0]. [0,-1]]
    # valid_moves
    # directions.each do |dir|
    #   valid_moves_for_dir = []
    #   #build path in direction until blocked.
    #   valid_moves += valid_moves_for_dir
    # end
  end


end

class Bishop < Sliding_pieces

  def symbol
    if color == :w
      "♝"
    else
      "♗"
    end
  end

  def moves(pos)
    x, y = pos
    possible_pos = []
    dir1 = []
    dir2 = []
    dir3 = []
    dir4 = []
    (1...8).each do |i|
      possible_pos << [(x + i), (y + i)] unless (x+i) > 7 || (y+i) > 7

      possible_pos << [(x - i), (y - i)] unless (x-i) < 0 || (y-i) < 0
      possible_pos << [(x - i), (y + i)] unless (x-i) < 0 || (y+i) > 7
      possible_pos << [(x + i), (y - i)] unless (x+i) > 7 || (y-i) < 0
    end
    possible_pos
  end



end

class Rook < Sliding_pieces
  def symbol
    if color == :w
      "♜"
    else
      "♖"
    end
  end

  def moves(pos)
    x, y = pos
    possible_pos = []

    (1...8).each do |i|
      possible_pos << [ x, (y + i)] unless (y+i) > 7
      possible_pos << [ x, (y - i)] unless (y-i) < 0
      possible_pos << [(x - i), y] unless (x-i) < 0
      possible_pos << [(x + i), y] unless (x+i) > 7
    end
    possible_pos
  end

end

class Queen < Sliding_pieces
  def symbol
    if color == :w
      "♕"
    else
      "♛"
    end
  end

  def moves(pos)
    x, y = pos
    possible_pos = []

    (1...8).each do |i|
      possible_pos << [(x + i), (y + i)] unless (x+i) > 7 || (y+i) > 7
      possible_pos << [(x - i), (y - i)] unless (x-i) < 0 || (y-i) < 0
      possible_pos << [(x - i), (y + i)] unless (x-i) < 0 || (y+i) > 7
      possible_pos << [(x + i), (y - i)] unless (x+i) > 7 || (y-i) < 0
      possible_pos << [ x, (y + i)] unless (y+i) > 7
      possible_pos << [ x, (y - i)] unless (y-i) < 0
      possible_pos << [(x - i), y] unless (x-i) < 0
      possible_pos << [(x + i), y] unless (x+i) > 7
    end
    possible_pos
  end


end

###########################################################
###########################################################

class Stepping_pieces < Piece

end

class Knight < Stepping_pieces

  def symbol
    if color == :w
      "♞"
    else
      "♘"
    end
  end

  def moves(pos)
    x, y = pos
    possible_pos = [-2,-1,1,2].permutation(2).select{ |x,y| x.abs + y.abs == 3 }
    knight_moves = []

    possible_pos.each do |pair|
      if (0...8).include?(pair[0] + x) && (0...8).include?(pair[1] + y)
        knight_moves << [(pair[0] + x), (pair[1] + y)]
      end
    end
    knight_moves
  end


end


class King < Stepping_pieces
  def symbol
    if color == :w
      "♚"
    else
      "♔"
    end
  end

  def moves(pos)
    #DRY!!!!!!
    x, y = pos
    king_moves = []

    possible_pos = ([-1,0,1].repeated_permutation(2)).to_a
    possible_pos -= [[0,0]]

    possible_pos.each do |pair|
      if (0...8).include?(pair[0] + x) && (0...8).include?(pair[1] + y)
        king_moves << [(pair[0] + x), (pair[1] + y)]
      end
    end
    king_moves
  end
end

class Pawn < Piece
  def symbol
    if color == :w
      "♟"
    else
      "♙"
    end
  end

  def moves(pos)
    x, y = pos
    pawn_moves = []

    #Pawn can move forward unless something directly in front of it
    #Pawn can move diagonally if there is a piece in diagonal spot
    if self.color == :w
      #x decreases
      pawn_moves << [(x - 1), y]
    else
      #x increases (color black)
      pawn_moves << [(x + 1), y]
    end
  end

end



class NullPiece
  def present?
    false
  end

  def to_s
    "   "
  end
end
