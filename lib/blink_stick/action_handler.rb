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
