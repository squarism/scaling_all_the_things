num = ARGV[0].to_i

array = []
start_time = Time.now
num.times do |i|
  array << i
end
end_time = Time.now

size = array.count.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
puts "Done.  Array size is #{size}"

elapsed = end_time - start_time
na, ms = (elapsed * 1000).divmod(1000)
mm, ss = elapsed.divmod(60)
hh, mm = mm.divmod(60)
dd, hh = hh.divmod(24)

puts "Time: %d hours, %d minutes, %d seconds, %05.2f milliseconds" % [hh, mm, ss, ms]

# Done.  Array is 1,000,000
# Time: 00.00 hours, 00.00 minutes, 00 seconds, 132.54 milliseconds

# Done.  Array is 10,000,000
# Time: 0 hours, 0 minutes, 1 seconds, 246.86 milliseconds

# Done.  Array is 100,000,000
# Time: 0 hours, 0 minutes, 13 seconds, 73.54 milliseconds

# Done.  Array is 1,000,000,000
# Time: 0 hours, 4 minutes, 44 seconds, 226.27 milliseconds