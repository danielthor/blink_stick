require 'libusb'
require 'color'
require 'blink_stick/version'
require 'blink_stick/color_handler'

class BlinkStick
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

  def blink(options = {})
    current_color = self.color
    # TODO: make it color_or_options to default to just entering a color to blink
    options = {
      color: current_color,
      blink: 1,
      frequency: 0.2,
      turn_off: false
    }.merge(options)

    perform_blink(options, current_color)
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

  private

  def perform_blink(options, current_color)
    options[:blink].times do
      sleep options[:frequency]

      self.color = options[:color]

      sleep options[:frequency]

      if options[:turn_off]
        self.off
      else
        self.color = current_color
      end
    end
  end
end
