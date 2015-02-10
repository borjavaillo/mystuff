#!/usr/bin/ruby
# In order to use the ruby sdk v2
require 'aws-sdk'

# Establishing a connection via the autoscaling API client
autoscaling = Aws::AutoScaling::Client.new

# we also use the ec2 resource in order to map instance-id to security group
resource = Aws::EC2::Resource.new


puts "##############################"
puts "# Autoscaling Groups Summary #"
puts "##############################"

# Each autoscaling group contains an array of instances, since we don't know how many instances
# we'll find in each autoscaling group but we know that there'll be at least one we pick up 
# the first instance-id on each autoscalcing group ( variable instances_array )
resp = autoscaling.describe_auto_scaling_groups.auto_scaling_groups.each do |group|
instances_array =  "#{group.instances.map(&:instance_id).first}"

# and now we find out which security group maps to the instance_id returned by the instances_array variable
sg = resource.instance("#{instances_array}").security_groups.map(&:group_name) 

puts "Autoscaling Group Name: #{group.auto_scaling_group_name}"
puts "Minimum, Maximum and Desired instances: #{group.min_size}, #{group.max_size}, #{group.desired_capacity}"
puts "Number of current instances: #{group.instances.map(&:instance_id).count}"
puts "ELB: #{group.load_balancer_names}"
puts "Instances: #{group.instances.map(&:instance_id)}"
puts "SecurityGroup: #{sg}"
puts "################################################"
puts "                                                "
end
