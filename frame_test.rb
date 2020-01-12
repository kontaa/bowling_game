require 'bundler/setup'
require 'test/unit'

require './frame'

class FrameTest < Test::Unit::TestCase
  setup do
    @f = Frame.new
  end

  test '全ての投球がガター' do
    @f.record_shot(0)
    @f.record_shot(0)
    assert_equal 0, @f.score
  end

  test '全ての投球が1pin' do
    @f.record_shot(1)
    @f.record_shot(1)
    assert_equal 2, @f.score
  end

  test '1投目はフレームは未完了' do
    @f.record_shot(1)
    refute @f.finished?
  end

  test '2投するとフレームは完了' do
    @f.record_shot(1)
    refute @f.finished?

    @f.record_shot(1)
    assert @f.finished?
  end

  test '1投目10本(ストライク)の場合,フレームは完了' do
    @f.record_shot(10)
    assert @f.finished?
  end

  test '5,5の場合、スベア' do
    @f.record_shot(5)
    @f.record_shot(5)
    assert @f.spare?
  end

  test '0,10の場合、スベア' do
    @f.record_shot(0)
    @f.record_shot(10)
    assert @f.spare?
  end

  test '1投目の場合、スベアではない' do
    @f.record_shot(5)
    refute @f.spare?
  end

  test '0,0の場合、スベアではない' do
    @f.record_shot(0)
    @f.record_shot(0)
    refute @f.spare?
  end

  test '0,9の場合、スベアではない' do
    @f.record_shot(0)
    @f.record_shot(9)
    refute @f.spare?
  end

  test '1投目10本の場合、ストライク' do
    @f.record_shot(10)
    assert @f.strike?
  end

  test '1投目1本の場合、ストライクではない' do
    @f.record_shot(1)
    refute @f.strike?
  end

  test '1,1の場合、ストライクではない' do
    @f.record_shot(1)
    @f.record_shot(1)
    refute @f.strike?
  end

  test '1,9の場合、ストライクではない' do
    @f.record_shot(1)
    @f.record_shot(9)
    refute @f.strike?
  end

  # bonusの概念を追加

  test 'スペア 5,5 bonus=5' do
    @f.record_shot(5)
    @f.record_shot(5)
    @f.add_bonus(5)
    assert_equal 15, @f.score
  end

  test 'ストライク 10 bonus=5,0' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(5)
    @f.add_bonus(0)
    assert_equal 15, @f.score
  end

  test 'ストライク 10 bonus=0,5' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(0)
    @f.add_bonus(5)
    assert_equal 15, @f.score
  end

  test 'ストライク 10 bonus=2,3' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(2)
    @f.add_bonus(3)
    assert_equal 15, @f.score
  end

  test 'ストライク&スペア 10 bonus=5,5' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(5)
    @f.add_bonus(5)
    assert_equal 20, @f.score
  end

  test 'ストライク&ダブル 10 bonus=10,5' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(10)
    @f.add_bonus(5)
    assert_equal 25, @f.score
  end

  test 'ストライク&ターキー 10 bonus=10,10' do
    @f.record_shot(10)
    # skip
    @f.add_bonus(10)
    @f.add_bonus(10)
    assert_equal 30, @f.score
  end



end

