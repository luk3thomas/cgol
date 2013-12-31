require 'cell'

class Board
  attr_accessor :size, :cells, :population

  def initialize(size = [80, 100], population = [])
    @size = size
    @population = population
    populate
  end

  def rows
    @size.first
  end

  def columns
    @size.last
  end

  private
    def lookup row, column
      @population[row][column] unless @population[row].nil?
    end

    def populate
      @cells = []
      rows.times do |i|
        _row = []
        columns.times do |j|
          _row << Cell.new(lookup(i, j))
        end
        @cells << _row
      end
    end
end
