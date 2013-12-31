require 'spec_helper'
require 'automaton'
require 'board'

describe Automaton do
  before(:each) do
    @board = Board.new [3,3], [[0, 0, 0], [1, 1, 1], [0, 0,0]]
    @board2 = Board.new [3,3], [[0, 1, 0], [0, 1, 0], [0, 1,0]]
    @automaton = Automaton.new @board
  end

  it "correctly ocillates" do
    # +-----------+     +-----------+
    # |   |   |   |     |   | X |   |
    # +-----------+     +-----------+
    # | X | X | X |  => |   | X |   |
    # +-----------+     +-----------+
    # |   |   |   |     |   | X |   |
    # +-----------+     +-----------+
    #@automaton.cycle!
    #@board.cells.should eq(@board2.cells)
  end

  context "Selecting neighbors" do
    data = [
      [ [-1,0], [] ],
      [ [-1,1], [] ],
      [ [-1,2], [] ],
      [ [0,0], [[0,1], [1,1], [1,0]] ],
      [ [0,1], [[0,0], [0,2], [1,0], [1,1], [1,2]] ],
      [ [0,2], [[0,1], [1,1], [1,2]] ],
      [ [1,0], [[0,0], [0,1], [1,1], [2,1], [2,0]] ],
      [ [1,1], [[0,0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]] ],
      [ [1,2], [[0,1], [0,2], [1,1], [2,1], [2,2]] ],
      [ [2,0], [[1,0], [1,1], [2,1]] ],
      [ [2,1], [[1,0], [1,1], [1,2], [2,0], [2,2]] ],
      [ [2,2], [[1,1], [1,2], [2,1]] ],
      [ [3,0], [] ],
      [ [3,1], [] ],
      [ [3,2], [] ],
    ]
    data.each do |d|
      it "selects #{d.last.size} neighbors for #{d.first}" do
        @automaton.neighbors(d.first).sort.should eq(d.last.sort)
      end
    end
  end
end
