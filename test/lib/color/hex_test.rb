require_relative '../../test_helper'
 
describe Color do

  it "must convert hex string to rgb array" do
    Color.hex(COLOR_HEX_VALUE).must_equal COLOR_RGB_VALUE
  end

  it "must convert hex with hash string to rgb array" do
    Color.hex('#' + COLOR_HEX_VALUE).must_equal COLOR_RGB_VALUE
  end

  it "must ignore hex case when converting" do
    Color.hex(COLOR_HEX_VALUE.upcase).must_equal COLOR_RGB_VALUE
  end

end
