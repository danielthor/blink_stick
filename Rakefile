#!/usr/bin/env rake
require "bundler/gem_tasks"
 
require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/blink_stick'
  t.test_files = FileList['test/lib/blink_stick/*_test.rb', 'test/lib/color/*_test.rb']
  t.verbose = true
end
 
task :default => :test
