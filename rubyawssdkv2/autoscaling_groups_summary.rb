#!/usr/bin/ruby
require 'aws-sdk'
autoscaling = Aws::AutoScaling::Client.new
resp = autoscaling.describe_auto_scaling_groups.auto_scaling_groups.each do |group|
puts "#{group.auto_scaling_group_name} min:#{group.min_size} max:#{group.max_size} desired:#{group.desired_capacity} ELB:#{group.load_balancer_names} Instances:#{group.instances.map(&:instance_id)}"
end
