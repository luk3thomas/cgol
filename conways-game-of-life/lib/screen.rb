class Screen
  def initialize board
    @board = board
  end

  def draw!
    clear
    map = @board.cells.map{|row| row.map{|cell| cell.alive ? '+' : ' ' }.join(' ')}.join("\n")
    border = '-' * (@board.columns * 2 - 1)
    border = ['+', border, '+'].join('')
    map.gsub!(/^|$/, '|')
    map = [border, map, border].join("\n")
    puts map
    puts "Population: #{@board.cells.flatten.select{|n| n.alive}.size}"
  end

  def clear
    system('clear')
  end
end
