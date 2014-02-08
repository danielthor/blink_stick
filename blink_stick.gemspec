# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blink_stick/version'

Gem::Specification.new do |spec|
  spec.name          = "blink_stick"
  spec.version       = BlinkStick::VERSION
  spec.authors       = ["Daniel Thor", "Björn Skarner"]
  spec.email         = ["daniel.thor@gmail.com"]
  spec.description   = %q{Control your BlinkStick}
  spec.summary       = %q{BlinkStick is a USB-controlled smart pixel by Agile Innovative. This gem helps you control it.}
  spec.homepage      = "https://github.com/danielthor/blink_stick/"
  spec.license       = "MIT"
  spec.metadata      = { "issue_tracker" => "https://github.com/danielthor/blink_stick/issues" }

  spec.requirements  << "An Agile Innovative BlinkStick available at http://blinkstick.com"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "libusb", "~> 0.4"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard-minitest"
end
