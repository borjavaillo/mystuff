#!/usr/bin/ruby
require 'aws-sdk-v1'

auto_scaling = AWS::AutoScaling.new
auto_scaling.activities.each do |activity|
  puts "#{activity.auto_scaling_group_name} #{activity.description} started at #{activity.start_time} ending at #{activity.end_time}"
end
