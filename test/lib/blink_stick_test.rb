require_relative '../test_helper'

describe BlinkStick do
  subject { BlinkStick }

  MockDevice = Struct.new :open

  class BlinkStickMock
    def serial
      @serial ||= ('a'..'z').to_a.sample(5).join
    end
  end

  it "must have constant VENDOR_ID 0x20A0" do
    subject::VENDOR_ID.must_equal 0x20A0
  end

  it "must have constant PRODUCT_ID 0x41E5" do
    subject::PRODUCT_ID.must_equal 0x41E5
  end

  describe 'self.usb' do
    it 'must only instantiate one LIBUSB::Context' do
      usb = subject.usb

      subject.usb.must_equal usb
    end
  end

  describe 'self.find_all' do
    it 'will return the located devices instantiated' do
      mock_usb = MiniTest::Mock.new
      return_value = [MockDevice.new, MockDevice.new, MockDevice.new]

      mock_usb.expect :devices, return_value,
       [idVendor: subject::VENDOR_ID, idProduct: subject::PRODUCT_ID]

      subject.stub :usb, mock_usb do
        subject.find_all.length.must_equal 3
      end
    end
  end

  describe 'self.find_by_serial' do
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

  describe 'self.first' do
    it 'must return the first available device' do
      bsm1 = BlinkStickMock.new
      bsm2 = BlinkStickMock.new
      device_array = [bsm1, bsm2]

      subject.stub :find_all, device_array do
        subject.first.must_equal bsm1
      end
    end
  end
end
