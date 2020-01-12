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

  test 'ストライク ダブル 10 10 3,1 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(1, 1)
    record_shot_times(0, 14)
    assert_equal 41, @game.score
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
  end

  test 'ストライク＆スペア 10 5,5 3,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(5, 1)
    record_shot_times(5, 1)
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 14)
    assert_equal 36, @game.score
  end

  test 'ストライク＆スペア 10 10 5,5 3,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(5, 1)
    record_shot_times(5, 1)
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 12)
    assert_equal 61, @game.score
  end

  test 'ストライク＆スペア&ストライク 10 10 5,5 10 3,0 0...' do
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(5, 1)
    record_shot_times(5, 1)
    record_shot_times(10, 1)
    # skip shot
    record_shot_times(3, 1)
    record_shot_times(0, 1)
    record_shot_times(0, 10)
    assert_equal 81, @game.score
  end

  test '全ての投球がガターの場合の第１フレームの得点' do
    record_shot_times(0, 20)
    assert_equal 0, @game.score_frame(1)
  end

  test '全ての投球がガターの場合の第１0フレームの得点' do
    record_shot_times(0, 20)
    assert_equal 0, @game.score_frame(10)
  end

  test '全ての投球が1ピンの場合の第１フレームの得点' do
    record_shot_times(1, 20)
    assert_equal 2, @game.score_frame(1)
  end

  test '全ての投球が1ピンの場合の第10フレームの得点' do
    record_shot_times(1, 20)
    assert_equal 2, @game.score_frame(10)
  end

  private

  def record_shot_times(pins, n)
    n.times do 
      @game.record_shot(pins)
    end
  end
end

