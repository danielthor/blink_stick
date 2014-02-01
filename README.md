# BlinkStick

[BlinkStick](http://blinkstick.com) is a USB-controlled smart pixel. This gem will help you control it.

Note: This is a work in progress. It does not exist on rubygems.org, yet.

This code is heavily based on [Arvydas Juskevicius](https://github.com/arvydas/) [blinkstick-ruby](https://github.com/arvydas/blinkstick-ruby) code.

## Installation

Add this line to your application's Gemfile:

    gem 'blink_stick', :git => 'git://github.com/danielthor/blink_stick.git'

And then execute:

    $ bundle

## Usage

```ruby
# list all blink sticks
BlinkStick.find_all

# find by USB serial
BlinkStick.find_by_serial('BS000563-1.1')

# find first blink stick (you'll probably use this if you only have 1 blink stick connected)
bs = BlinkStick.first

# set color using rgb
bs.color = [255,255,255]
# or hex (with or without leading #)
bs.color = "#00FF00"
# or use css color names (see lib/color/name.rb for list)
bs.color = :blue

# make it blink (it's a BLINK stick, after all)
# color to blink with
bs.blink(color: 'abc123')
# number of times to blink (default: 1)
bs.blink(color: 'abc123', blink: 5)
# change the frequency/intensity of the blink
bs.blink(color: 'abc123', blink: 5, frequency: 0.8)
# turns the blink stick off after blink (defaults to previous color otherwise)
bs.blink(color: 'abc123', turn_off: true)

# random color
bs.random_color

# turn it off
bs.off

# get serial
# ex: BS000563-1.1
bs.serial

# description (BlinkStick)
bs.description

# manufacturer (Agile Innovative Ltd)
bs.manufacturer
```

## TODO

[ ] Finish tests (I'm still learning!)
[ ] Cleanup code
[ ] Make sure Color module isn't polluting namespace
[ ] Validation when setting colors
[ ] Error handling
[ ] World domination

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

To Arvydas Juskevicius for making the BlinkStick and for providing example code to work from, Thanks!
