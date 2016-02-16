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
    self[start] = NullPiece.new
  end

  def rows
    @grid
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def find_pieces
    pieces = []
    (0...grid.length).each do |row|
      row.each_with_index do |val, col|
        pieces << val if val.is_a?(Piece)
      end
    end
    pieces
  end

  def find_king_pos(color)
    find_pieces.each do |piece|
      return piece.pos if piece.is_a?(King) && piece.color == color
    end
  end

  def find_color_pieces(color)
    find_pieces.select { |piece| piece.color == color }
  end

  def in_check?
    bpieces = find_color_pieces(:b)
    wpieces = find_color_pieces(:w)

    wpieces.each do |piece|
      return true if piece.moves(pos).include?(find_king_pos(:b))
    end
    bpieces.each do |piece|
      return true if piece.moves(pos).include?(find_king_pos(:w))
    end

    false
  end

  def populate(color)
    if color == :b
      i = 0
      x = 1
    else
      i = 7
      x = 6
    end

    self[[i,0]] = (Rook.new(color, self, [i,0]))
    self[[i,1]] = (Knight.new(color, self, [i,1]))
    self[[i,2]] = (Bishop.new(color, self, [i,2]))
    self[[i,3]] = (King.new(color, self, [i,3]))
    self[[i,4]] = (Queen.new(color, self, [i,4]))
    self[[i,5]] = (Bishop.new(color, self, [i,5]))
    self[[i,6]] = (Knight.new(color, self, [i,6]))
    self[[i,7]] = (Rook.new(color, self, [i,7]))

    (0..7).each do |y|
      self[[x,y]] = (Pawn.new(color, self, [x, y]))
    end

  end

  def populate_set


  end

  # def rows(color)
  #   back_row = []
  #
  #   if color == :b
  #     (0..7).to_a.each do |i|
  #       back_row << [0, i]
  #     end
  #   else
  #     (0..7).to_a.each do |i|
  #       back_row << [7, i]
  #     end
  #   end
  #   back_row
  # end

end

class InvalidMove < StandardError
end
