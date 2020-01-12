class Frame
  def initialize
    @score = 0
    @count = 0
  end

  def record_shot(pins)
    @score += pins
    @count += 1
  end

  def score
    @score
  end

  def finished?
    @count > 1 || @score == 10
  end
end
