
require "colorize"
require_relative "cursorable"
require_relative "board"
require_relative "piece"

class Display
  attr_reader :selected
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_yellow
    else
      bg = :green
    end
    { background: bg, color: :white }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
  end

  def move
    @selected = nil
    until @selected
      self.render
      @selected = self.get_input
    end
    @selected
  end
end

# board = Board.new
# display = Display.new(board)
# board.populate(:w)
# display.move
#p display.selected
