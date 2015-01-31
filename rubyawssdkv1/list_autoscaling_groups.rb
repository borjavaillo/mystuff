#!/usr/bin/ruby
require 'aws-sdk-v1'

auto_scaling = AWS::AutoScaling.new
auto_scaling.groups.map(&:name).each do |groups|
  puts "#{groups}"
end
