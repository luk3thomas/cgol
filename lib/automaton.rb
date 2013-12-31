class Automaton
  def initialize board
    @board = board
  end

  def cycle!
    _cells = @board.cells.each_with_index.map do |row, i|
      row.each_with_index.map do |cell, j|
        alive?(cell, [i, j])
      end
    end

    _cells.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @board.cells[i][j].alive = _cells[i][j]
      end
    end
  end

  def alive? cell, coords
    neighbors = select_neighbors(coords)
    if cell.alive
      sustained?(neighbors) || !( lonely?(neighbors) || crowded?(neighbors) )
    else
      lush?(neighbors)
    end
  end

  def select_neighbors coords
    find_neighbors(coords).map{|n| @board.cells[n.first][n.last]}.flatten.uniq
  end

  def find_neighbors coords
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

  def lonely? neighbors
    occupied(neighbors).between?(0, 1)
  end

  def crowded? neighbors
    occupied(neighbors).between?(4, 8)
  end

  def sustained? neighbors
    occupied(neighbors).between?(2, 3)
  end

  def lush? neighbors
    occupied(neighbors) == 3
  end

  private

    def occupied neighbors
      neighbors.map{|n| n.alive || nil }.compact.size
    end

    def within_bounds coords
      row, column = coords
      (row >= 0 && row < @board.rows) && (column >= 0 && column < @board.columns)
    end
end
