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
    f = @frames.last
    f.record_shot(pins)
    calc_bonus(pins)
    @bonus = update_bonus
    @bonus << f if f.spare? or f.strike?
    @frames << Frame.new if f.finished?
  end

  def score_frame(frame_no)
    @frames[frame_no -1].score
  end

  #-----------
  private
  #-----------

  def calc_bonus(pins)
    @bonus.each do |f|
      f.add_bonus(pins) if f.need_bonus?
    end
  end
  
  def update_bonus
    @bonus.select do |f|
      f.need_bonus?
    end
  end

end

