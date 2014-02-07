module BlinkStick::ColorHandler
  def color=(value)
    data_out = transform_color_to_hex(Color.parse(value))

    @handle.control_transfer(bmRequestType: 0x20,
                             bRequest: 0x9,
                             wValue: 0x1,
                             wIndex: 0x0000,
                             dataOut: data_out)
  end

  def color
    result = @handle.control_transfer(bmRequestType: 0x80 | 0x20,
                                      bRequest: 0x1,
                                      wValue: 0x1,
                                      wIndex: 0x0000,
                                      dataIn: 4)

    [result[1].ord, result[2].ord, result[3].ord]
  end

  def off
    self.color = [0, 0, 0]
  end

  def random_color
    self.color = random_rgb
  end

  private

  def random_rgb
    r = Random.new
    [r.rand(255), r.rand(255), r.rand(255)]
  end

  def transform_color_to_hex(value)
    1.chr + value[0].chr + value[1].chr + value[2].chr
  end
end
