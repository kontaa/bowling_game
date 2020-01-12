require './frame'

class BowlingGame
  attr_reader :score

  def initialize
    @score = 0
    @spare = false
    @strike = 0
    @strike2 = 0
    @last_pins = 0
    @frame = 0      # {0, 1}
    @frames = [Frame.new]
  end

  def record_shot(pins)
    f = @frames.last
    f.record_shot(pins)

    add_score(pins) if spare_at_prev?
    add_score(pins)
    add_score(pins + @last_pins) if strike_at_prev2?

    reset_spare
    dec_count_for_strike

    set_strike if strike?(pins)
    set_spare if spare?(pins)
    save_at(pins)
    if strike_at?
      frame_first
    else
      frame_next
    end
    if f.finished?
      @frames << Frame.new
    end
  end

  def score_frame(frame_no)
    @frames[frame_no -1].score
  end

  private

  def dec_count_for_strike
    @strike -= 1 if @strike > 0
    @strike2 -= 1 if @strike2 > 0
  end

  def strike_at_prev2?
    (@strike == 1 || @strike2 == 1)
  end

  def save_at(pins)
    @last_pins = pins
  end

  def strike_at?
    (@strike == 2 || @strike2 == 2)
  end

  def add_score(pins)
    @score += pins
  end

  def strike?(pins)
    (pins == 10 && @frame == 0)
  end

  def set_strike
    if @strike == 0
      @strike = 2
    else
      @strike2 = 2
    end
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

  def frame_first
    @frame = 0
  end

  def frame_next
    @frame = next_frame
  end

  def next_frame
    (@frame + 1) % 2
  end
end

