require 'libusb'
require 'color'
require 'blink_stick/version'
require 'blink_stick/action_handler'
require 'blink_stick/action_handler/fade_action'
require 'blink_stick/color_handler'

class BlinkStick
  include BlinkStick::ActionHandler
  include BlinkStick::ColorHandler

  VENDOR_ID  = 0x20A0
  PRODUCT_ID = 0x41E5

  def self.usb
    @usb ||= LIBUSB::Context.new
  end

  def self.find_all
    usb = BlinkStick.usb

    usb_devices = usb.devices(idVendor: VENDOR_ID,
                              idProduct: PRODUCT_ID)

    usb_devices.map do |device|
      b = BlinkStick.new
      b.open(device)

      b
    end
  end

  def self.find_by_serial(serial)
    find_all.each do |b|
      return b if b.serial == serial
    end

    nil
  end

  def self.first
    find_all.first
  end

  def open(device = nil)
    usb = BlinkStick.usb

    if (device)
      @device = device
    else
      @device = usb.devices(idVendor: VENDOR_ID,
                            idProduct: PRODUCT_ID).first
    end

    @handle = @device.open
  end

  def serial
    @device.serial_number
  end

  def manufacturer
    @device.manufacturer
  end

  def description
    @device.product
  end
end
