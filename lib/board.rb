require 'cell'

class Board
  attr_accessor :size, :cells

  def initialize size = [80, 100]
    @size = size
    populate
  end

  def rows
    @size.first
  end

  def columns
    @size.last
  end

  private
    def populate
      @cells = []
      rows.times do
        _row = []
        columns.times do
          _row << Cell.new
        end
        @cells << _row
      end
    end
end
