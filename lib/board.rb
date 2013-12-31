require 'cell'

class Board
  attr_accessor :size, :cells

  def initialize args = {}
    defaults = {
      size: [80, 100],
    }
    defaults.merge(args).each do |k, v|
      instance_variable_set( "@#{k}", v )
    end
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
