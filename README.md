## Where am I.
This project aims to compare the performance of different languages.  There are many things wrong with this idea but I don't care.  I want to know when and where different things throw up in your face.

For example, make a list of numbers 0 to 1 billion.  Like `[0, 1, 2, 3 …]`.  You'd think this would be trivial but it's not in some cases.  I realized this in my favorite language Ruby.  You really can't just 'do it'.  You have to be careful and specific.

The tests:

- Arrays (for example arrays.js, arrays.py, arrays.scala, arrays.rb) counts from 0 to different large numbers and keeps the iteration.  The timing portion is solely around the creation of the array.

Some functional experiments popped up along the way, for example in the simple Array test.

- How do you get a command line argument?  (For the size of the array)
- How do you compute elapsed time?
- If you get milliseconds for time, how do you compute minutes or seconds elapsed?
- How do you do string interpolation for printing the results nicely?
- How do you print an array's length?

## Just Show Me the Results
    In format mins:secs.millis
	+-----------+-------+-------+-------+-----------+
	| language  |  1M   |  10M  | 100M  |    1B     |
	+-----------+-------+-------+-------+-----------+
	| C         | 0     | 0     | 1     | 7         |
	| Node (JS) | 0.117 | 2.280 | DNF   | DNF       |
	| Python    | 0.993 | 2.932 | 25.25 | DNF       |
	| Ruby      | 0.132 | 1.246 | 13.73 | 01:50.980 |
	| Scala     | 0.004 | 0.013 | 1.005 | 9.056     |
	+-----------+-------+-------+-------+-----------+
	
	Notes:
     C - currently working on greater timing resolution than seconds
     Node - proccesses limited to 1gb, did not finish > 10 million
     Python - Used 32gb of RAM and DNF after 10+ minutes on 1 billion
     Ruby - used about 8gb
     Scala - Had to set -Xmx8g for 1billion run
    
    Versions:
     C - gcc version 4.2.1 (test compiled with -O2)
     Node - v0.10.2
     Python - 2.7.2
     Ruby - 1.9.3p385
     Scala - 2.10.1


## Notes
Here's a log of all the fun I had.

### C
C was a PITA compared to the higher level languages.  But, no big surprise, was very fast.  Non-optimized (-O2) compilation was slower than Scala but then O2 made it faster than Scala.

### Python
Used 32gb of memory (much of it swap) on a 24gb machine.  Never completed after 10+ minutes.  It ran 100m ok.  Most languages seem to really start to show their limits at 100m+.

### Scala
Ran out of memory on 1B elements using ArrayBuffer but using ListBuffer not only ran in 3gb on my laptop but also ran with both cores automatically?

CPU at 190% at times.  Ran really hot and for a long time.

    1 [|||||||||||||||||||||||||||||||96.7%] 
    2 [|||||||||||||||||||||||||||||||99.3%] 
    Mem[|||||||||||||||||||||||||3810/3840MB] 
    Swp[|||||||||||||||||||||||||3466/4096MB]
    Tasks: 134 total, 3 running
    Load average: 2.32 2.19 1.50 Uptime: 05:50:51

On my 8-core, I saw 780% at times.


Changed to 

    val buf = (0 to 1000000000 - 1).par.map { i  => i }.toList

Trying to get 1 billion numbers in a list.

With 8gb xmx
`java.lang.OutOfMemoryError: GC overhead limit exceeded`


Had to use pure Ints.

`val array = new Array[Int](num)`

    // this didn't work even with 16gb of RAM
    // it just spins forever on 1B.  All smaller limits it worked.
    val buf = (0 to num - 1).par.map { i  => i }.toList

    // this method didn't work either, ArrayBuffer is too slow
    val array = ArrayBuffer.empty[Int]