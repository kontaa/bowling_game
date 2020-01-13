class Frame
  def initialize
    @score = 0
    @count = 0
    @bonus = 0
    @bonus_count = 0
  end

  def record_shot(pins)
    @score += pins
    @count += 1
  end

  def score
    @score + @bonus
  end

  def finished?
    @count > 1 || @score == 10
  end

  def spare?
    @count == 2 && @score == 10
  end

  def strike?
    @count == 1 && @score == 10
  end

  def add_bonus(bonus)
    @bonus_count += 1
    @bonus += bonus
  end

  def need_bonus?
    if spare?
      @bonus_count < 1
    elsif strike?
      @bonus_count < 2
    else
      false
    end
  end

end

