class Screen
  def initialize board
    @board = board
  end

  def draw!
    clear
    puts @board.cells.map{|row| row.map{|cell| cell.alive ? '*' : ' ' }.join(' ') }.join("\n")
    puts "Population: #{@board.cells.flatten.select{|n| n.alive}.size}"
  end

  def clear
    system('clear')
  end
end
