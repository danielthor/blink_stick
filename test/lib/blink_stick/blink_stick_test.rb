require_relative '../../test_helper'
 
describe BlinkStick do
 
  subject { BlinkStick }

  it "must have class variable VENDOR_ID 0x20A0" do
    subject.class_variable_get(:@@VENDOR_ID).must_equal 0x20A0
  end
  
  it "must have class variable PRODUCT_ID 0x41E5" do
    subject.class_variable_get(:@@PRODUCT_ID).must_equal 0x41E5
  end

  it "must respond to find_by_serial" do
    subject.must_respond_to :find_by_serial
  end

end
