require 'spec_helper'
require 'board'

describe Board do
  before(:each) { @board = Board.new }

  context "Methods" do
    it { @board.rows.should eq(@board.size.first) }
    it { @board.columns.should eq(@board.size.last) }
  end

  context "Default variables" do
    context "size" do
      it "should have a default size array" do
        @board.size.is_a?(Array).should eq(true)
      end

      it "the size array should contain rows and columns" do
        @board.size.count.should eq(2)
      end

      it "the rows and columns are integers" do
        @board.size.each do |n|
          n.is_a?(Integer).should eq(true)
        end
      end

      it "should accept custom board dimensions" do
        custom_dimensions = [1200, 300]
        @board2 = Board.new( custom_dimensions )
        @board2.size.should eq(custom_dimensions)
      end
    end
  end
  context "Cells" do
    it "should be an array of arrays" do
      @board.cells.is_a?(Array).should eq(true)
    end
    it "the cell rows should equal the board rows" do
      @board.cells.count.should eq(@board.rows)
    end
    it "the cell columns should equal the board columns" do
      @board.cells.first.count.should eq(@board.columns)
    end
  end

  it "creates a 3x3 board with a vertically centered blinker" do
    # +-----------+
    # |   |   |   |
    # +-----------+
    # | X | X | X |
    # +-----------+
    # |   |   |   |
    # +-----------+
    
    board = Board.new [3,3], [[0,0,0], [1,1,1], [0,0,0]]
    board.cells.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        case i
        when 1
          cell.alive.should eq(true)
        else
          cell.alive.should eq(false)
        end
      end
    end
  end
end
