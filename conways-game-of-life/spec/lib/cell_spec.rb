require 'spec_helper'
require 'cell'

describe Cell do
  before(:each) { @cell = Cell.new }
  context "Default variables" do
    it "responds to alive" do
      @cell.should respond_to(:alive)
    end
    it "is false by default" do
      @cell.alive.should eq(false)
    end
    it "can be initialized as true" do
      [true, 1, "some string", 2039].each do |state|
        Cell.new(state).alive.should eq(true)
      end
    end
    it "can be initialized as false" do
      [false, 0, ""].each do |state|
        Cell.new(state).alive.should eq(false)
      end
    end
  end
end
