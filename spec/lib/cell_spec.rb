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
  end
end
