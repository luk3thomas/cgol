class Board
  attr_accessor :size

  def initialize args = {}
    defaults = {
      size: [80, 100],
    }
    defaults.merge(args).each do |k, v|
      instance_variable_set( "@#{k}", v )
    end
  end
end
