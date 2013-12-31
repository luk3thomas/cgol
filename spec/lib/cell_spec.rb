require 'spec_helper'
require 'cell'

describe Cell do
  before(:each) { @cell = FactoryGirl.build(:cell) }
  context "Default variables" do
    it "responds to alive" do
      @cell.should respond_to(:alive)
    end
    it "is false by default" do
      @cell.alive.should eq(false)
    end
  end
end
