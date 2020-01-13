require './frame'

class BowlingGame
  def initialize
    @frames = [Frame.new]
    @spare_frame = nil
    @strike_frame = nil
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
    @spare_frame = curr_frame if curr_frame.spare?

    strike_bonus(pins)
    double_bonus(pins)
    if curr_frame.strike?
      if @strike_frame.nil?
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
    if @spare_frame&.need_bonus?
      @spare_frame.add_bonus(pins)
      @spare_frame = nil
    end
  end

  def strike_bonus(pins)
    if @strike_frame&.need_bonus?
      @strike_frame.add_bonus(pins)
      @strike_frame = nil unless @strike_frame.need_bonus?
    end
  end

  def set_strike
    @strike_frame = curr_frame
  end

  def double_bonus(pins)
    if @double_frame&.need_bonus?
      @double_frame.add_bonus(pins)
      @double_frame = nil unless @double_frame.need_bonus?
    end
  end
    
  def set_double
    @double_frame = curr_frame
  end

end

