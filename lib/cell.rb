class Cell
  attr_accessor :alive

  def initialize alive = nil
    @alive = alive || false
  end
end
