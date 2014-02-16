module BlinkStick::ActionHandler
  require 'blink_stick/action_handler/fade_action'

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

  def fade(color1, color2, options = {})
    parser = ->(color) { Color.parse(color) }

    color1 = parser.call(color1)
    color2 = parser.call(color2)

    FadeAction.call self, color1, color2, options
  end

  def random_pulse(n = 2)
    pulse send(:random_rgb), n
  end

  def pulse(color = [255, 255, 255], n = 2)
    self.off

    start_value = [0, 0, 0]
    end_value = color

    n.times do
      fade start_value, end_value
      fade end_value, start_value
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
