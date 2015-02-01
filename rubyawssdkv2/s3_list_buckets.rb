#!/usr/bin/ruby
require 'aws-sdk'
s3 = Aws::S3::Client.new
resp = s3.list_buckets
resp.buckets.map.each do |bucket|
  puts "#{bucket.name} #{bucket.creation_date}"
end
