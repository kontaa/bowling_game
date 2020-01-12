class BowlingGame
  attr_reader :score

  def initialize
    @score = 0
    @spare = false
    @strike = 0
    @last_pins = 0
    @frame = 0      # {0, 1}
  end

  def record_shot(pins)
    if spare_at_prev?
      @score += pins * 2
    else
      @score += pins
    end
    reset_spare

    if @strike == 2

      @strike = 1
    elsif @strike == 1
      @score += pins + @last_pins
      @strike = 0
    end

    #-------------

    if strike?(pins)
      set_strike
    end

    if spare?(pins)
      set_spare
    end

    @last_pins = pins

    if @strike == 2
      @frame = 0
    else
      @frame = next_frame
    end
  end

  private

  def strike?(pins)
    (pins == 10 && @frame == 0)
  end

  def set_strike
    @strike = 2
  end

  def reset_spare
    @spare = false
  end

  def set_spare
    @spare = true
  end

  def spare_at_prev?
    @spare
  end

  def spare?(pins)
    (pins != 0 && (@last_pins + pins) == 10 && @frame == 1)
  end

  def next_frame
    (@frame + 1) % 2
  end
end

