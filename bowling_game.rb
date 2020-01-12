class BowlingGame
  def initialize
    @score = 0
  end
  def record_shot(pins)
    @score += pins
  end
  def score
    @score 
  end
end

