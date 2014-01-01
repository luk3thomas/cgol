require 'spec_helper'
require 'automaton'
require 'board'

blinker = [
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 1, 1, 1, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
]

toad = [
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 1, 1, 0],
  [0, 1, 1, 1, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
]

board_blinker = Board.new([5,5], blinker)
board_toad = Board.new([6,6], toad)

describe Automaton do

  before(:each) do
    @board = board_blinker
    @big_board = board_toad
    @automaton = Automaton.new @board
  end

  #    Blinker: @board
  #    5 x 5
  #           
  #    +-------------------+     +-------------------+
  #    |   |   |   |   |   |     |   |   |   |   |   |
  #    +-------------------+     +-------------------+
  #    |   |   |   |   |   |     |   |   | X |   |   |
  #    +-------------------+     +-------------------+
  #    |   | X | X | X |   |  => |   |   | X |   |   |
  #    +-------------------+     +-------------------+
  #    |   |   |   |   |   |     |   |   | X |   |   |
  #    +-------------------+     +-------------------+
  #    |   |   |   |   |   |     |   |   |   |   |   |
  #    +-------------------+     +-------------------+

  #    Toad: @big_board
  #    6 x 6
  #
  #    +-----------------------+     +-----------------------+
  #    |   |   |   |   |   |   |     |   |   |   |   |   |   |
  #    +-----------------------+     +-----------------------+
  #    |   |   |   |   |   |   |     |   |   |   | X |   |   |
  #    +-------------------+---+     +---+-------------------+
  #    |   |   | X | X | X |   |  => |   | X |   |   | X |   |
  #    +-------------------+---+     +---+-------------------+
  #    |   | X | X | X |   |   |     |   | X |   |   | X |   |
  #    +-------------------+---+     +---+-------------------+
  #    |   |   |   |   |   |   |     |   |   | X |   |   |   |
  #    +-------------------+---+     +---+-------------------+
  #    |   |   |   |   |   |   |     |   |   |   |   |   |   |
  #    +-----------------------+     +-----------------------+

  context "identifies state" do
    it "lonely" do
      neighbors = @automaton.select_neighbors([2,1])
      @board.cells[2][1].alive.should eq(true)
      @automaton.lonely?(neighbors).should eq(true)
    end

    it "lush" do
      neighbors = @automaton.select_neighbors([1,2])
      @board.cells[1][2].alive.should eq(false)
      @automaton.lush?(neighbors).should eq(true)
    end

    it "sustain" do
      neighbors = @automaton.select_neighbors([2,2])
      @board.cells[2][2].alive.should eq(true)
      @automaton.sustained?(neighbors).should eq(true)
    end

    it "crowded" do
      @automaton = Automaton.new @big_board
      neighbors = @automaton.select_neighbors([2,2])
      @board.cells[2][2].alive.should eq(true)
      @automaton.crowded?(neighbors).should eq(true)
    end
  end


  context "correctly ocillates blinker" do
    before(:all) do
      @b = board_blinker
      @automaton = Automaton.new( @b )
      @automaton.cycle!
    end

    [
      [ false , false , false , false , false ] , 
      [ false , false , true  , false , false ] , 
      [ false , false , true  , false , false ] , 
      [ false , false , true  , false , false ] , 
      [ false , false , false , false , false ] , 
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
      @b = board_toad
      @automaton = Automaton.new( @b )
      @automaton.cycle!
    end

    [
      [ false , false , false , false , false , false ] , 
      [ false , false , false , true  , false , false ] , 
      [ false , true  , false , false , true  , false ] , 
      [ false , true  , false , false , true  , false ] , 
      [ false , false , true  , false , false , false ] , 
      [ false , false , false , false , false , false ] , 
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
      [ [1,1], [[0,0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]] ],

      # Out of bounds
      [ [0,0], [[0,1], [1,1], [1,0], [1,4], [0,4], [4,4], [4,0], [4,1]] ],
      [ [0,4], [[4,3], [4,4], [4,0], [0,0], [1,0], [1,4], [1,3], [0,3]] ],
      [ [4,0], [[3,0], [3,1], [4,1], [0,0], [4,4], [0,1], [3,4], [0,4]] ],
      [ [4,4], [[3,4], [3,3], [4,3], [0,0], [0,4], [4,0], [3,0], [0,3]] ],
    ]
    data.each do |d|
      it "selects #{d.last.size} neighbors for #{d.first}" do
        @automaton.find_neighbors(d.first).sort.should eq(d.last.sort)
      end
    end
  end
end
