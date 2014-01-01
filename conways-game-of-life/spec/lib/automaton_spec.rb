require 'spec_helper'
require 'automaton'
require 'board'

blinker = [
  [0, 0, 0],
  [1, 1, 1],
  [0, 0, 0],
]

toad = [
  [0, 0, 0, 0],
  [0, 1, 1, 1],
  [1, 1, 1, 0],
  [0, 0, 0, 0],
]

describe Automaton do
  before(:each) do
    @board = Board.new [3,3], blinker 
    @big_board = Board.new([5,5], toad)
    @board2 = Board.new [3,3], [[0, 1, 0], [0, 1, 0], [0, 1,0]]
    @automaton = Automaton.new @board
  end

  #    Blinker: @board
  #    3 x 3
  #
  #    +-----------+     +-----------+
  #    |   |   |   |     |   | X |   |
  #    +-----------+     +-----------+
  #    | X | X | X |  => |   | X |   |
  #    +-----------+     +-----------+
  #    |   |   |   |     |   | X |   |
  #    +-----------+     +-----------+

  #    Toad: @big_board
  #    4 x 4
  #
  #    +---------------+     +---------------+
  #    |   |   |   |   |     |   |   | X |   |
  #    +---------------+     +---------------+
  #    |   | X | X | X |  => | X |   |   | X |
  #    +---------------+     +---------------+
  #    | X | X | X |   |     | X |   |   | X |
  #    +---------------+     +---------------+
  #    |   |   |   |   |     |   | X |   |   |
  #    +---------------+     +---------------+

  context "identifies state" do
    it "lonely" do
      neighbors = @automaton.select_neighbors([1,2])
      @board.cells[1][2].alive.should eq(true)
      @automaton.lonely?(neighbors).should eq(true)
    end

    it "lush" do
      neighbors = @automaton.select_neighbors([0,1])
      @board.cells[0][1].alive.should eq(false)
      @automaton.lush?(neighbors).should eq(true)
    end

    it "sustain" do
      neighbors = @automaton.select_neighbors([1,1])
      @board.cells[1][1].alive.should eq(true)
      @automaton.sustained?(neighbors).should eq(true)
    end

    it "crowded" do
      @automaton = Automaton.new @big_board
      neighbors = @automaton.select_neighbors([1,1])
      @board.cells[1][1].alive.should eq(true)
      @automaton.crowded?(neighbors).should eq(true)
    end
  end


  context "correctly ocillates blinker" do
    before(:all) do
      @b = Board.new([3, 3], blinker)
      @automaton = Automaton.new( @b )
      @automaton.cycle!
    end

    [
      [ false, true, false ] ,
      [ false, true, false ] ,
      [ false, true, false ] ,
    ].each_with_index do |row, i|
      row.each_with_index do |col, j|
        it "[#{i}, #{j}] is #{col}" do
          @b.cells[i][j].alive.should eq(col)
        end
      end
    end
  end

  context "correctly hops the toad" do
    before(:all) do
      @b = Board.new([4, 4], toad)
      @automaton = Automaton.new( @b )
      @automaton.cycle!
    end

    [
      [ false , false , true  , false ] , 
      [ true  , false , false , true ]  , 
      [ true  , false , false , true ]  , 
      [ false , true  , false , false ] , 
    ].each_with_index do |row, i|
      row.each_with_index do |col, j|
        it "[#{i}, #{j}] is #{col}" do
          @b.cells[i][j].alive.should eq(col)
        end
      end
    end
  end

  context "Selecting neighbors" do
    data = [
      [ [0,0], [[0,1], [1,1], [1,0]] ],
      [ [0,1], [[0,0], [0,2], [1,0], [1,1], [1,2]] ],
      [ [0,2], [[0,1], [1,1], [1,2]] ],
      [ [1,0], [[0,0], [0,1], [1,1], [2,1], [2,0]] ],
      [ [1,1], [[0,0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]] ],
      [ [1,2], [[0,1], [0,2], [1,1], [2,1], [2,2]] ],
      [ [2,0], [[1,0], [1,1], [2,1]] ],
      [ [2,1], [[1,0], [1,1], [1,2], [2,0], [2,2]] ],
      [ [2,2], [[1,1], [1,2], [2,1]] ],

      # Out of bounds
      [ [-1,0], [[1,0], [1,1], [2,1]] ],
      [ [-1,1], [[1,0], [1,1], [1,2], [2,0], [2,2]] ],
      [ [-1,2], [[1,1], [1,2], [2,1]] ],
      [ [3,0], [[0,1], [1,1], [1,0]] ],
      [ [3,1], [[0,0], [0,2], [1,0], [1,1], [1,2]] ],
      [ [3,2], [[0,1], [1,1], [1,2]] ],
      [ [0,-1], [[0,1], [1,1], [1,2]] ],
      [ [1,-1], [[0,1], [0,2], [1,1], [2,1], [2,2]] ],
      [ [2,-1], [[1,1], [1,2], [2,1]] ],
      [ [0,3], [[0,1], [1,1], [1,0]] ],
      [ [1,3], [[0,0], [0,1], [1,1], [2,1], [2,0]] ],
      [ [2,3], [[1,0], [1,1], [2,1]] ],
    ]
    data.each do |d|
      it "selects #{d.last.size} neighbors for #{d.first}" do
        @automaton.find_neighbors(d.first).sort.should eq(d.last.sort)
      end
    end
  end
end
