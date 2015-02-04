#!/usr/bin/ruby
require 'aws-sdk'
autoscaling = Aws::AutoScaling::Client.new
ec2 = Aws::EC2::Client.new
puts "##############################"
puts "# Autoscaling Groups Summary #"
puts "##############################"
resp = autoscaling.describe_auto_scaling_groups.auto_scaling_groups.each do |group|
# instances_array contains the first instance in i-xxxx format of each autoscaling group
# from that we want to find the security group and the instance names in friendly DNS sshable format
instances_array =  "#{group.instances.map(&:instance_id).first}"
ec2.describe_instances( instance_ids: ["i-99ea5c7d"] ).each do |response|
  puts response.reservations
end


#puts "Autoscaling Group Name: #{group.auto_scaling_group_name}"
#puts "Minimum, Maximum and Desired instances: #{group.min_size}, #{group.max_size}, #{group.desired_capacity}"
#puts "Number of current instances: #{group.instances.map(&:instance_id).count}"
#puts "ELB: #{group.load_balancer_names}"
#puts "Instances: #{group.instances.map(&:instance_id)}"
#puts "################################################"
#puts "                                                "
end
