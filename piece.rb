require 'byebug'

class Piece
  attr_accessor :board
  attr_reader :color, :pos

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


  def validate_moves
    actually_valid_moves = []
    moves(pos).each do |dir|
      #debugger
      dir.each_with_index do |position, idx|
        if board[position].is_a?(Piece) && board[position].color != color #lands on enemy
          actually_valid_moves << position
          break
        elsif board[position].is_a?(Piece) && board[position].color == color #lands on friendly
          break
        else
          actually_valid_moves << position
        end
      end
    end
    actually_valid_moves
  end



  def all_moves_in_directions


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
    dir1, dir2, dir3, dir4 = [], [], [], []

    (1...8).each do |i|
      dir1 << [(x + i), (y + i)] unless (x+i) > 7 || (y+i) > 7
      dir2 << [(x - i), (y - i)] unless (x-i) < 0 || (y-i) < 0
      dir3 << [(x - i), (y + i)] unless (x-i) < 0 || (y+i) > 7
      dir4 << [(x + i), (y - i)] unless (x+i) > 7 || (y-i) < 0
    end
    possible_pos << dir1 << dir2 << dir3 << dir4
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
    dir1, dir2, dir3, dir4 = [],[],[],[]

    (1...8).each do |i|
      dir1 << [ x, (y + i)] unless (y+i) > 7
      dir2 << [ x, (y - i)] unless (y-i) < 0
      dir3 << [(x - i), y] unless (x-i) < 0
      dir4 << [(x + i), y] unless (x+i) > 7
    end
    possible_pos << dir1 << dir2 << dir3 << dir4
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
    dir1, dir2, dir3, dir4, dir5, dir6, dir7, dir8 = [],[],[],[],[],[],[],[]

    (1...8).each do |i|
      dir1 << [(x + i), (y + i)] unless (x+i) > 7 || (y+i) > 7
      dir2 << [(x - i), (y - i)] unless (x-i) < 0 || (y-i) < 0
      dir3 << [(x - i), (y + i)] unless (x-i) < 0 || (y+i) > 7
      dir4 << [(x + i), (y - i)] unless (x+i) > 7 || (y-i) < 0
      dir5 << [ x, (y + i)] unless (y+i) > 7
      dir6 << [ x, (y - i)] unless (y-i) < 0
      dir7 << [(x - i), y] unless (x-i) < 0
      dir8 << [(x + i), y] unless (x+i) > 7
    end
    possible_pos << dir1 << dir2 << dir3 << dir4 << dir5 << dir6 << dir7 << dir8
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
