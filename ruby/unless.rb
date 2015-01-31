#!/usr/bin/ruby
print "Integer please: "
user_input = Integer(gets.chomp)
unless user_input < 3
  puts "You picked 2 or higher"
else
  puts "You picked an integer smaller than 3"
end
