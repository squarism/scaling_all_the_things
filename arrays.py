# come on python, save us
import sys, time, datetime
import locale

locale.setlocale(locale.LC_ALL, 'en_US')

# another way to do it
# datetime.timedelta(milliseconds=elapsed)
# but it's not equivalent
def prntime(ms): 
	s=ms/1000
	na,milli = divmod((ms * 1000), 1000)
	m,s=divmod(s,60) 
	h,m=divmod(m,60) 
	return h,m,s,milli

try:
	sys.argv[1]
except IndexError:
	print "hey, give me a number for array size like 1000000"
	exit(1)

num = int(sys.argv[1])

array = []
start_time = datetime.datetime.now()
for i in range(0, num):
	array.append(i)

end_time = datetime.datetime.now()

size = locale.format("%d", len(array), grouping=True)
print "Done. Array size is %s" % size

elapsed = (end_time - start_time).total_seconds() * 1000

print 'Time: %d hours, %d minutes, %d seconds, %d milliseconds' % prntime(elapsed) 


# Done. Array size is 1,000,000
# Time: 0 hours, 0 minutes, 0 seconds, 993 milliseconds

# Done. Array size is 10,000,000
# Time: 0 hours, 0 minutes, 2 seconds, 932 milliseconds

# Done. Array size is 100,000,000
# Time: 0 hours, 0 minutes, 25 seconds, 25 milliseconds

# managed to use 28gb of memory
