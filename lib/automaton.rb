class Automaton
  def initialize board
    @board = board
  end

  def cycle!
    @board.cells.each_with_index do |row, i|
      @board.cells[i].each_with_index do |cell, j|
        @board.cells[i][j].alive = alive?([i, j]) 
      end
    end
  end

  def alive? coords
    sustained?(coords) || lush?(coords)
  end

  def neighbors coords
    row, column = coords
    arr = [
      [row - 1, column - 1] ,
      [row - 1, column - 0] ,
      [row - 1, column + 1] ,
      [row - 0, column - 1] ,
      [row - 0, column + 1] ,
      [row + 1, column - 1] ,
      [row + 1, column - 0] ,
      [row + 1, column + 1] ,
    ]
    within_bounds(coords) ? arr.select {|c| within_bounds(c) } : []
  end

  private
    def sustained? coords
      row, column = coords
    end
    def lush? coords
      row, column = coords
    end

    def within_bounds coords
      row, column = coords
      (row >= 0 && row < @board.rows) && (column >= 0 && column < @board.columns)
    end
end
