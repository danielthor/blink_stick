require_relative '../../test_helper'
 
describe Color do

  it "must parse hex value" do
    Color.parse(COLOR_HEX_VALUE).must_equal COLOR_RGB_VALUE
  end

  it "must pase same rgb value" do
    Color.parse(COLOR_RGB_VALUE).must_equal COLOR_RGB_VALUE
  end

end
