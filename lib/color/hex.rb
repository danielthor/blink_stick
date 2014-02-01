module BlinkColor
  def self.hex(value)
    # remove hash if exists
    value = value.gsub(/#/, '')

    rgb = []
    rgb.push(value[0..1].hex) # red
    rgb.push(value[2..3].hex) # green
    rgb.push(value[4..5].hex) # blue

    return rgb
  end
end