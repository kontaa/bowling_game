require './frame'

class BowlingGame
  def initialize
    @frames = [Frame.new]
    @spare = []
    @strikes = []
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

    set_spare if curr_frame.spare?
    set_strike if curr_frame.strike?

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
    @spare = @spare.select do |f|
      if f.need_bonus?
        f.add_bonus(pins)
        f.need_bonus?
      end
    end
  end

  def set_spare
    @spare << curr_frame
  end

  def strike_bonus(pins)
    @strikes = @strikes.select do |f|
      if f.need_bonus?
        f.add_bonus(pins)
        f.need_bonus?
      end
    end
  end

  def set_strike
    @strikes << curr_frame
  end

end

