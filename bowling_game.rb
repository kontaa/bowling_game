require './frame'

class BowlingGame
  def initialize
    @frames = [Frame.new]

    @spare = 0
    @spare_frame = nil

    @strike = 0
    @strike_frame = nil

    @double = 0
    @double_frame = nil
  end

  def score
    score = 0
    @frames.each do |f|
      score += f.score
    end
    score
  end

  def record_shot(pins)
    curr_frame.record_shot(pins)
    spare_bonus(pins)
    strike_bonus(pins)
    double_bonus(pins)

    if curr_frame.spare?
      set_spare
    end
    if curr_frame.strike?
      if @strike == 0
        set_strike
      else
        set_double
      end
    end
    @frames << Frame.new if curr_frame.finished?
  end

  def score_frame(frame_no)
    @frames[frame_no -1].score
  end

  #-----------
  private
  #-----------

  def curr_frame
    @frames.last
  end

  def spare_bonus(pins)
    if @spare > 0
      @spare -= 1
      @spare_frame.add_bonus(pins)
      @spare_frame = nil
    end
  end

  def set_spare
    @spare = 1
    @spare_frame = @frames.last
  end

  def strike_bonus(pins)
    if @strike > 0
      @strike -= 1
      @strike_frame.add_bonus(pins)
      @strike_frame = nil if @strike == 0
    end
  end

  def set_strike
    @strike = 2
    @strike_frame = @frames.last
  end

  def double_bonus(pins)
    if @double > 0
      @double -= 1
      @double_frame.add_bonus(pins)
      @double_frame = nil if @double == 0
    end
  end
    
  def set_double
    @double = 2
    @double_frame = @frames.last
  end

end

