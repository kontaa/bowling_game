require './frame'

class BowlingGame
  def initialize
    @frames = [Frame.new]
    @bonus = []
  end

  def score
    @frames.map{|f| f.score}.sum
  end

  def record_shot(pins)
    curr_frame.record_shot(pins)
    bonus(pins)
    if curr_frame.spare? or curr_frame.strike?
      set_bonus
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

  def bonus(pins)
    @bonus = @bonus.select do |f|
      if f.need_bonus?
        f.add_bonus(pins)
        f.need_bonus?
      end
    end
  end

  def set_bonus
    @bonus << curr_frame
  end

end

