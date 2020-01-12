require 'bundler/setup'
require 'test/unit'
#require 'pry-byebug'

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
    assert_equal 0, @game.score, "total"
    assert_equal 0, @game.score_frame(1), "frame:1"
    assert_equal 0, @game.score_frame(10), "frame:10"
  end

  test '全ての投球で1ピンのみ' do
    record_shot_times(1, 20)
    assert_equal 20, @game.score, "total"
    assert_equal 2, @game.score_frame(1), "frame:1"
    assert_equal 2, @game.score_frame(10)
  end

  test 'スペア 3,7 4,0 0...' do
    record_shot_times(3, 1)
    record_shot_times(7, 1)
    record_shot_times(4, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 16)
    assert_equal 18, @game.score
    assert_equal 14, @game.score_frame(1)
    assert_equal  4, @game.score_frame(2)
  end

  test 'スペア 2,5 5,1 0...' do
    record_shot_times(2, 1)
    record_shot_times(5, 1)
    record_shot_times(5, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 16)
    assert_equal 13, @game.score
    assert_equal  7, @game.score_frame(1)
    assert_equal  6, @game.score_frame(2)
  end

  test 'スペア 0,10 0,10 0...' do
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(0, 16)
    assert_equal 20, @game.score
    assert_equal 10, @game.score_frame(1)
    assert_equal 10, @game.score_frame(2)
  end

  test 'スペア 0,10 1,10 0...' do
    record_shot_times(0, 1)
    record_shot_times(10, 1)
    record_shot_times(1, 1)
    record_shot_times(9, 1)
    record_shot_times(0, 16)
    assert_equal 21, @game.score
    assert_equal 11, @game.score_frame(1)
    assert_equal 10, @game.score_frame(2)
  end

  test 'ストライク 10 3,0 0,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 16, @game.score
    assert_equal 13, @game.score_frame(1)
    assert_equal  3, @game.score_frame(2)
  end

  test 'ストライク 10 0,4 0,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(0, 1)
    record_shot_times(4, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 18, @game.score
    assert_equal 14, @game.score_frame(1)
    assert_equal  4, @game.score_frame(2)
  end

  test 'ストライク 10 3,4 0,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(4, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 24, @game.score
    assert_equal 17, @game.score_frame(1)
    assert_equal  7, @game.score_frame(2)
  end

  test 'ストライク 10 3,4 1,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(4, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 25, @game.score
    assert_equal 17, @game.score_frame(1)
    assert_equal  7, @game.score_frame(2)
  end

  test 'ストライク 10 3,4 1,0 10 3,4 0...' do
    record_shot_times(10, 1) #1
    # skip shot
    record_shot_times(3, 1)  #2
    record_shot_times(4, 1)
    record_shot_times(1, 1)  #3
    record_shot_times(0, 1)
    record_shot_times(10, 1) #4
    # skip shot
    record_shot_times(3, 1)  #5
    record_shot_times(4, 1)
    record_shot_times(0, 10) #6...
    assert_equal 49, @game.score
    assert_equal 17, @game.score_frame(1)
    assert_equal  7, @game.score_frame(2)
    assert_equal  1, @game.score_frame(3)
    assert_equal 17, @game.score_frame(4)
    assert_equal  7, @game.score_frame(5)
    assert_equal  0, @game.score_frame(6)
  end

  test 'ストライク ダブル 10 10 3,1 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 14)
    assert_equal 41, @game.score
    assert_equal 23, @game.score_frame(1)
    assert_equal 14, @game.score_frame(2)
    assert_equal  4, @game.score_frame(3)
  end

  test 'ストライク ターキー 10 10 10 3,1 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 12)
    assert_equal 71, @game.score
    assert_equal 30, @game.score_frame(1)
    assert_equal 23, @game.score_frame(2)
    assert_equal 14, @game.score_frame(3)
  end

  test 'ストライク＆スペア 10 5,5 3,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(4, 1)
    record_shot_times(6, 1)
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 36, @game.score
    assert_equal 20, @game.score_frame(1)
    assert_equal 13, @game.score_frame(2)
    assert_equal  3, @game.score_frame(3)
  end

  test 'ストライク＆スペア 10 10 5,5 3,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(4, 1)
    record_shot_times(6, 1)
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 12)
    assert_equal 60, @game.score
    assert_equal 24, @game.score_frame(1)
    assert_equal 20, @game.score_frame(2)
    assert_equal 13, @game.score_frame(3)
    assert_equal  3, @game.score_frame(4)
  end

  test 'ストライク＆スペア&ストライク 10 10 5,5 10 3,0 0...' do
    record_shot_times(10, 1)  #1
    # skip shot
    record_shot_times(10, 1)  #2
    # skip shot
    record_shot_times(4, 1)  #3
    record_shot_times(6, 1)
    record_shot_times(10, 1)  #4
    # skip shot
    record_shot_times(3, 1)  #5
    record_shot_times(0, 1)
    record_shot_times(0, 10)
    assert_equal 80, @game.score
    assert_equal 24, @game.score_frame(1)
    assert_equal 20, @game.score_frame(2)
    assert_equal 20, @game.score_frame(3)
    assert_equal 13, @game.score_frame(4)
    assert_equal  3, @game.score_frame(5)
  end

  private

  def record_shot_times(pins, n)
    n.times do 
      @game.record_shot(pins)
    end
  end
end

