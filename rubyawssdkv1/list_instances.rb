#!/usr/bin/ruby
require 'aws-sdk-v1'

ec2 = AWS::EC2.new

ec2.instances.map(&:id).each do |instance|
  puts "#{instance}"
end
