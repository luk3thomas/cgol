class Cell
  attr_accessor :alive

  def initialize alive = nil
    @alive = determine_state(alive)
  end

  private
  def determine_state input
    case true
    # Numbers
    when input.is_a?(Integer)
      !input.zero?
    # Strings
    when input.is_a?(String)
      !input.size.zero?
    # Boolean
    when !!input == input
      input
    else
      false
    end
  end
end
