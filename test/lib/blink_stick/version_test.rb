require_relative '../../test_helper'

describe BlinkStick do
  it "must be defined" do
    BlinkStick::VERSION.wont_be_nil
  end
end
