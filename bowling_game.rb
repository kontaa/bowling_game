class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @last_pins = 0
    @frame = 0      # {0, 1}
  end

  def record_shot(pins)
    if @spare
      @score += pins * 2
      @spare = false
    else
      @score += pins
    end

    if pins != 0 && (@last_pins + pins) == 10 && @frame == 1
      @spare = true
    end

    @last_pins = pins
    @frame = (@frame + 1) % 2
  end

  def score
    @score 
  end
end

