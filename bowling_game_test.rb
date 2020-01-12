require 'test/unit'

# Windows では winpty を使うことで、red green 表示できる
#
# 例
# @sh  $ winpty ruby <test program.rb>
# @vim :!winpty ruby %
#

require './bowling_game'

class BowlingGameTest < Test::Unit::TestCase
  setup do
    @game = BowlingGame.new
  end

  test '全ての投球がガター' do
    record_shot_times(0, 20)
    assert_equal 0, @game.score
  end

  test '全ての投球で1ピンのみ' do
    record_shot_times(1, 20)
    assert_equal 20, @game.score
  end

  test 'スペア 3,7 4,0 0...' do
    record_shot_times(3, 1)
    record_shot_times(7, 1)
    record_shot_times(4, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 16)
    assert_equal 18, @game.score
  end

  test 'スペア 2,5 5,1 0...' do
    record_shot_times(2, 1)
    record_shot_times(5, 1)
    record_shot_times(5, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 16)
    assert_equal 13, @game.score
  end

  test 'スペア 0,10 0,10 0...' do
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(0, 16)
    assert_equal 20, @game.score
  end

  test 'スペア 0,10 1,10 0...' do
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(1, 1)
    record_shot_times(10, 1)
    record_shot_times(0, 16)
    assert_equal 22, @game.score
  end

  test 'ストライク 10 3,3 1,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 23, @game.score
  end

  test 'ストライク 10 10 3,1 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 14)
    assert_equal 41, @game.score
  end

  test 'ストライク 10 10 1,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 14)
    assert_equal 41, @game.score
  end

  private

  def record_shot_times(pins, n)
    n.times do 
      @game.record_shot(pins)
    end
  end
end

