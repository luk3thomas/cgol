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
end
