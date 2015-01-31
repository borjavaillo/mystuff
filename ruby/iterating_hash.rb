#!/usr/bin/ruby
my_hash = {"First name"=>"Yukihiro", "Last name"=>"Matsumoto", "Age"=>47, "Nationality"=>"Japanese", "Nickname"=>"Matz"} 

my_hash.each do |key, value|
  puts key, my_hash[key]
end
