require './frame'

class BowlingGame
  attr_reader :score

  def initialize
    @score = 0
    @spare = false
    @strike = 0
    @strike2 = 0
    @frames = [Frame.new]
    @spare_frame = nil
    @strike_frame = nil
  end

  def record_shot(pins)
    curr_frame.record_shot(pins)

    add_score(pins)

    if spare_at_prev?
      add_score(pins)
      @spare_frame.add_bonus(pins)
      @spare_frame = nil
    end
    reset_spare
    set_spare if curr_frame.spare?

    if @strike == 2
      add_score(pins)
      @strike_frame.add_bonus(pins) if @strike_frame
    end
    if @strike2 == 2
      add_score(pins)
      @strike2_frame.add_bonus(pins) if @strike2_frame
    end
    if @strike == 1
      add_score(pins)
      @strike_frame.add_bonus(pins) if @strike_frame
    end
    if @strike2 == 1
      add_score(pins)
      @strike2_frame.add_bonus(pins) if @strike2_frame
    end
    dec_count_for_strike
    set_strike if curr_frame.strike?

    @frames << Frame.new if curr_frame.finished?
  end

  def score_frame(frame_no)
    @frames[frame_no -1].score
  end

  #-----------
  private

  def curr_frame
    @frames.last
  end

  def dec_count_for_strike
    @strike -= 1 if @strike > 0
    @strike2 -= 1 if @strike2 > 0
    @strike_frame = nil if @strike == 0
    @strike2_frame = nil if @strike2 == 0
  end

  def set_strike
    if @strike == 0
      @strike = 2
      @strike_frame = @frames.last
    else
      @strike2 = 2
      @strike2_frame = @frames.last
    end
  end

  def reset_spare
    @spare = false
  end

  def set_spare
    @spare = true
    @spare_frame = @frames.last
  end

  def spare_at_prev?
    @spare
  end

  ###

  def add_score(pins)
    @score += pins
  end

end

