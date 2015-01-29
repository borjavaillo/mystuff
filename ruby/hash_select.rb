#!/usr/local/bin/ruby
grades = { :alice => 100,
  :bob => 92,
  :chris => 95,
  :dave  => 97
}

puts grades.select {|name, grade| grade < 97}
