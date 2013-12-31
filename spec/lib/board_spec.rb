require 'spec_helper'
require 'board'

describe Board do
  context "Default variables" do
    before(:each) { @board = Board.new }

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
        @board2 = Board.new( size: custom_dimensions )
        @board2.size.should eq(custom_dimensions)
      end
    end
  end
end
