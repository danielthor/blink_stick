module BlinkStick::ActionHandler
  def blink(blink_color = nil, options = {})
    current_color = self.color

    blink_color = [0, 0, 0] if blink_color.nil?

    options = {
      blink: 1,
      frequency: 0.2,
      turn_off: false
    }.merge(options)

    perform_blink(blink_color, current_color, options)
  end

  # fade from one color to another
  # TODO: going from one color to another that is "far away" in a short amount of time
  #       will give you I/O problems. Libusb (of if it's USB itself) can't handle the
  #       speed and number of operations
  #       create some kind of "break" so it will skip some color values on the way
  def fade(color1, color2, options = {})
    options = { time: 5 }.merge(options)

    # break down colors
    r1, g1, b1 = color1
    r2, g2, b2 = color2

    delta_r = r1 - r2
    delta_g = g1 - g2
    delta_b = b1 - b2
    # find greatest distance to travel form one vector value to the other
    delta_max = [delta_r, delta_g, delta_b].map(&:abs).max
    puts "delta max = #{delta_max}"

    # in what direction is the vector value moving
    direction_r = (r1 > r2) ? -1 : 1
    direction_g = (g1 > g2) ? -1 : 1
    direction_b = (b1 > b2) ? -1 : 1

    # set initial rgb values
    r, g, b = color1

    for i in 1..delta_max
      # find the time to sleep for each loop
      # so traveling the max distance takes options[:time] to complete
      sleepy_time = options[:time].to_f/delta_max.to_f
      puts "sleepy time #{sleepy_time}"
      sleep sleepy_time

      # set values depending on if it's "time to move"
      # this will essentially make all the color vectors move at the same pace
      # greatest distance to travel changes color/moves each loop
      # while least distance only relative
      # don't know how else to explain it :(
      r = r + direction_r if (i % (delta_max/delta_r.abs)) == 0
      g = g + direction_g if (i % (delta_max/delta_g.abs)) == 0
      b = b + direction_b if (i % (delta_max/delta_b.abs)) == 0

      puts "color r=#{r} g=#{g} b=#{b}"
      self.color = [r, g, b]
    end
  end

  private

  def perform_blink(blink_color, current_color, options)
    options[:blink].times do
      sleep options[:frequency]

      self.color = blink_color

      sleep options[:frequency]

      if options[:turn_off]
        self.off
      else
        self.color = current_color
      end
    end
  end
end
