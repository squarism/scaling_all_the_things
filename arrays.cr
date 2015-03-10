# This has to be run with `crystal build arrays.cr`
# Maybe there's a way to get ARGV correctly.  It thinks
# I mean a file when I call it like a script.
# `crystal arrays.cr 100` doesn't work.
# Run this with ./arrays 100  after doing `crystal build arrays.cr`.

num = ARGV[0].to_i

array = [] of Number
start_time = Time.now
num.times do |i|
  array << i
end
end_time = Time.now

size = array.count.to_s.reverse.gsub(/(\d{3})(?=\d)/, "\\1,").reverse
puts "Done.  Array size is #{size}"

elapsed = end_time - start_time
puts elapsed.inspect

