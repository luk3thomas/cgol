class Game
  def initialize screen, automaton, iterations, frames_per_second
    @screen = screen
    @automaton = automaton
    @frames_per_second = frames_per_second

    (iterations).times do
      @screen.draw!
      @automaton.cycle!
      sleep (1.0 / @frames_per_second)
    end
  end
end
