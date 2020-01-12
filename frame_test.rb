require 'bundler/setup'
require 'test/unit'

require './frame'

class FrameTest < Test::Unit::TestCase
  test '全ての投球がガター' do
    f = Frame.new
    f.record_shot(0)
    f.record_shot(0)
    assert_equal 0, f.score
  end

  test '全ての投球が1pin' do
    f = Frame.new
    f.record_shot(1)
    f.record_shot(1)
    assert_equal 2, f.score
  end

  test '1投目はフレームは未完了' do
    f = Frame.new
    f.record_shot(1)
    refute f.finished?
  end

  test '2投するとフレームは完了' do
    f = Frame.new
    f.record_shot(1)
    refute f.finished?

    f.record_shot(1)
    assert f.finished?
  end

  test '1投目10本(ストライク)の場合,フレームは完了' do
    f = Frame.new
    f.record_shot(10)
    assert f.finished?
  end

end

