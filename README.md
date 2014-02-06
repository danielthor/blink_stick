# BlinkStick

[BlinkStick](http://blinkstick.com) is a USB-controlled smart pixel. This gem will help you control it.

Note: This is a work in progress. It does not exist on rubygems.org, yet.

This code is heavily based on [Arvydas Juskevicius](https://github.com/arvydas/) [blinkstick-ruby](https://github.com/arvydas/blinkstick-ruby) code.

## Prerequisites

### Libusb
Installation of the libusb package under Debian/Ubuntu:
`sudo apt-get install libusb-1.0-0-dev`

### Udev access
You will also need to grant access to the device in question.

This can be done as follows:

```sh
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"20a0\", ATTR{idProduct}==\"41e5\", MODE:=\"0666\"" | sudo tee /etc/udev/rules.d/85-blinkstick.rules
```

Then reload the udev rules with:

```sh
sudo udevadm control --reload-rules
```

or just reboot your computer.

## Installation

Add this line to your application's Gemfile:

    gem 'blink_stick', git: 'git://github.com/danielthor/blink_stick.git'

And then execute:

    $ bundle

## Usage

### Stand-alone

Run the following in your console:

```sh
$ rake console
```

### General usage

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
# color to blink with (default: current color)
bs.blink(color: 'abc123')
# number of times to blink (default: 1)
bs.blink(color: 'abc123', blink: 5)
# change the frequency/intensity of the blink (default: 0.2)
bs.blink(color: 'abc123', blink: 5, frequency: 0.8)
# turns the blink stick off after blink (default: previous color)
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

- Finish tests (I'm still learning!)
- Cleanup code
- Make sure Color module isn't polluting namespace
- Validation when setting colors
- Error handling
- World domination

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

To Arvydas Juskevicius for making the BlinkStick and for providing example code to work from, Thanks!
