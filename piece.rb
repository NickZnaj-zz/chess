require 'byebug'

class Piece
  def initialize(color, board)
    @color = color
    @board = board
  end

  def moves
    raise NotImplementedError.new("wrong method implemented.")
  end

end

###########################################################
###########################################################


class Sliding_pieces < Piece

  def bishop_moves(pos)
    x, y = pos
    possible_pos = []

    (1...8).each do |i|
      possible_pos << [(x + i), (y + i)] unless (x+i) > 7 || (y+i) > 7
      possible_pos << [(x - i), (y - i)] unless (x-i) < 0 || (y-i) < 0
      possible_pos << [(x - i), (y + i)] unless (x-i) < 0 || (y+i) > 7
      possible_pos << [(x + i), (y - i)] unless (x+i) > 7 || (y-i) < 0
    end
    possible_pos
  end

  def rook_moves(pos)
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

class Bishop < Sliding_pieces

  def moves
    bishop_moves
  end

end

class Rook < Sliding_pieces

def moves
  rook_moves
end

end

class Queen < Sliding_pieces

  def moves
    rook_moves + bishop_moves
  end


end

###########################################################
###########################################################

class Stepping_pieces < Piece

end

class Knight
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


class King
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

end



class NullPiece
  def present?
    false
  end

  def to_s
    "   "
  end
end
