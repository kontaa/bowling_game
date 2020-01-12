require 'test/unit'

# Windows では winpty を使うことで、red green 表示できる
#
# 例
# @sh  $ winpty ruby <test program.rb>
# @vim :!winpty ruby %
#

require './bowling_game'

class BowlingGameTest < Test::Unit::TestCase
  test '全ての投球がガター' do
    game = BowlingGame.new

    20.times do
      game.record_shot(0)
    end

    assert_equal 0, game.score
  end

  test '全ての投球で1ピンのみ' do
    game = BowlingGame.new

    20.times do
      game.record_shot(1)
    end

    assert_equal 20, game.score

  end
end

