class BlinkStick::ActionHandler::FadeAction
  def self.call(blink_stick, color1, color2, options = {})
    fa = self.new blink_stick, color1, color2
    fa.fade(options)
  end

  def initialize(blink_stick, color1, color2)
    @blink_stick = blink_stick
    @color1 = color1
    @color2 = color2

    @red, @green, @blue = start_color
  end

  def fade(options)
    @options = { time: 0.5 }.merge(options)

    primary_colors.each do |color, _|
      delta_for_primary_color color
      direction_for_primary_color color
    end

    perform
  end

  private
  attr_accessor :delta_red, :delta_green, :delta_blue, :direction_red,
  :direction_green, :direction_blue, :red, :green, :blue

  def primary_colors
    { red: 0, green: 1, blue: 2 }
  end

  def delta_for_primary_color(symbol)
    delta = find_delta retrieve_values location symbol
    setter "delta_#{symbol}".to_sym, delta
  end

  def direction_for_primary_color(symbol)
    direction = find_direction retrieve_values location symbol
    setter "direction_#{symbol}".to_sym, direction
  end

  def location(symbol)
    primary_colors.fetch(symbol)
  end

  def perform
    1.upto(distance) do |n|
      sleep sleepy_time
      apply_change n
      @blink_stick.color = current_color
    end
  end

  def apply_change(n)
    primary_colors.each do |color, _|
      if increase_color?(n, send("delta_#{color}".to_sym))
        send "#{color}=".to_sym, send(color) + send("direction_#{color}".to_sym)
      end
    end
  end

  def increase_color?(n, delta)
    (n % (distance.to_f / delta.to_f)).to_i == 0
  end

  def start_color
    @color1
  end

  def current_color
    [@red, @green, @blue]
  end

  # find the greatest distance to travel between the two points
  def distance
    @distance ||=  Math.sqrt(delta_red**2 + delta_green**2 + delta_blue**2)
  end

  def find_direction(values)
    (values[0] > values[1]) ? -1 : 1
  end

  def find_delta(values)
    (values[0] - values[1]).abs
  end

  def retrieve_values(n)
    [@color1[n], @color2[n]]
  end

  def setter(symbol, value)
    self.instance_variable_set("@#{symbol}".to_sym, value)
  end

  def sleepy_time
    @options[:time].to_f / distance.to_f
  end
end
