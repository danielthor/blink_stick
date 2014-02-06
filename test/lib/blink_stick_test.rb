require_relative '../test_helper'

describe BlinkStick do
  subject { BlinkStick }

  it "must have constant VENDOR_ID 0x20A0" do
    subject::VENDOR_ID.must_equal 0x20A0
  end

  it "must have constant PRODUCT_ID 0x41E5" do
    subject::PRODUCT_ID.must_equal 0x41E5
  end

  describe 'self.find_by_serial' do
    class BlinkStickMock
      def serial
        @serial ||= ('a'..'z').to_a.sample(5).join
      end
    end

    it "must respond to find_by_serial" do
      subject.must_respond_to :find_by_serial
    end

    it 'must collect the specified serial number' do
      bsm1 = BlinkStickMock.new
      bsm2 = BlinkStickMock.new
      device_array = [bsm1, bsm2]

      serial = bsm2.serial

      subject.stub :find_all, device_array do
        subject.find_by_serial(serial).must_equal bsm2
      end
    end

    it 'must return nil when none is found' do
      bsm1 = BlinkStickMock.new
      bsm2 = BlinkStickMock.new
      device_array = [bsm1, bsm2]

      subject.stub :find_all, device_array do
        subject.find_by_serial('12345').must_be_nil
      end
    end
  end
end
