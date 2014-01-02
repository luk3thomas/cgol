class Screen
  def initialize board
    @board = board
  end

  def draw! iteration
    clear
    map = @board.cells.map{|row| row.map{|cell| cell.alive ? '+' : ' ' }.join(' ')}.join("\n")
    border = '-' * (@board.columns * 2 - 1)
    border = ['+', border, '+'].join('')
    map.gsub!(/^|$/, '|')
    map = [border, map, border].join("\n")
    puts map
    puts "Population: #{@board.cells.flatten.select{|n| n.alive}.size.to_s.rjust(6)}"
    puts "Iteration:  #{iteration.to_s.rjust(6)}"
  end

  def clear
    system('clear')
  end
end
