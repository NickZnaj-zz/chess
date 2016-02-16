require_relative 'piece'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.new}}
  end


  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def move(start, end_pos)
    unless self[start].is_a?(Piece)
      raise ArgumentError.new "There is no piece here to move"
    end
    self[end_pos] = self[start]
    self[start] = nil
  end

  def rows
    @grid
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

end

class InvalidMove < StandardError
end
