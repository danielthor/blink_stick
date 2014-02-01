require "libusb"
require "color"
require "blink_stick/version"

class BlinkStick
  @@VENDOR_ID  = 0x20A0
  @@PRODUCT_ID = 0x41E5

  def open(device = nil)
    @@usb ||= LIBUSB::Context.new

    if (device)
      @device = device
    else
      @device = @@usb.devices(idVendor: @@VENDOR_ID, idProduct: @@PRODUCT_ID).first
    end

    @handle = @device.open
  end

  def self.find_all
    @@usb ||= LIBUSB::Context.new

    result = []

    @@usb.devices(idVendor: @@VENDOR_ID, idProduct: @@PRODUCT_ID).each { | device |
      b = BlinkStick.new
      b.open(device)

      result.push(b)
    }

    result
  end

  def self.find_by_serial(serial)
    self.find_all.each do |b|
      if b.serial == serial
        return b
      end
    end

    nil
  end

  def self.first
    self.find_all.first
  end

  def color=(value)
    value = Color.parse(value)
    @handle.control_transfer(bmRequestType: 0x20, bRequest: 0x9, wValue: 0x1, wIndex: 0x0000, dataOut: 1.chr + value[0].chr + value[1].chr + value[2].chr)
  end

  def color
   result = @handle.control_transfer(bmRequestType: 0x80 | 0x20, bRequest: 0x1, wValue: 0x1, wIndex: 0x0000, dataIn: 4)
   [result[1].ord, result[2].ord, result[3].ord]
  end

  def off
    self.color = [0, 0, 0]
  end

  def random_color
    r = Random.new
    self.color = [r.rand(255), r.rand(255), r.rand(255)]
  end

  def blink(options = {})
    current_color = self.color
    # TODO: make it color_or_options to default to just entering a color to blink
    options = { color: current_color, 
                blink: 1, 
                frequency: 0.2, 
                turn_off: false }.merge(options)

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
