require_relative '../../test_helper'

describe BlinkStick::ColorHandler do
  class ColorMock
    include BlinkStick::ColorHandler
  end

  subject { ColorMock.new }

  describe '#off' do
    it 'will set the color to [0,0,0]' do
      subject.stub :color=, [255, 255, 255] do
        subject.off.must_equal [0, 0, 0]
      end
    end
  end

  describe '#random_color' do
    it 'will return an array of 3 random numbers' do
      subject.stub :color=, [255,255,255] do
        subject.random_color.must_be_instance_of Array
      end
    end
  end
end
