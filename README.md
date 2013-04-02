## Let's Kill Some Computers.

 - Make an array of n-length.  `[0, 1, 2, 3 …]`.
 - Start at 1 million.
 - Go to 1 billion.
 - No tricks like lazy loading or enums.  Really create it the array, list, whatever your languages calls it.

You'd think this would be trivial but it's not in some cases.  I realized this in my favorite language Ruby.  You really can't just 'do it'.  You have to be careful and specific about memory usage.  You can't just toss in one billion objects.  They need to be small ints or something tiny.

The timing portions of these tests are solely around the creation of the array and not warm-up, tear-down, printing or anything outside the data structure creation.


## Just Show Me the Results

    In format mins:secs.millis
	+--------------------+-------+-------+-------+-----------+
	| language           |  1M   |  10M  | 100M  |    1B     |
	+--------------------+-------+-------+-------+-----------+
	| C                  | 0     | 0     | 1     | 7         |
	| Node (JS)          | 0.117 | 2.280 | DNF   | DNF       |
	| Python             | 0.993 | 2.932 | 25.25 | DNF       |
	| Ruby               | 0.132 | 1.246 | 13.73 | 01:50.980 |
	| Scala              | 0.004 | 0.013 | 1.005 | 9.056     |
        | Haskell (compiled) | 0.018 | 0.118 | 1.109 | 10.628    |
        |      (interpreted) | 0.254 | 0.352 | 1.361 | 11.494    |
	+--------------------+-------+-------+-------+-----------+

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
     Haskell - ghc 7.4.1

## Notes
Here's a log of all the fun I had.

### C
C was a PITA compared to the higher level languages.  But, no big surprise, was very fast.  Non-optimized (-O2) compilation was slower than Scala but then O2 made it faster than Scala.  I am more than willing to accept a better version of this test.  Especially one that dynamically allocates.

### Python
Used 32gb of memory (much of it swap) on a 24gb machine.  Never completed after 10+ minutes.  It ran 100m ok.

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

### Misc
Some learning experiments popped up along the way.  Even just doing this simple test it was interesting all the problems that had to be solved.

- How do you get a command line argument?  (For the size of the array)
- How do you compute elapsed time?
- If you get milliseconds for time, how do you compute minutes or seconds elapsed?
- How do you do string interpolation for printing the results nicely?
- How do you print an array's length?


### Haskell (contributed by @sixohsix)

- Using an array-based implementation is not faster. Probably because you have to iterate 1B times to fill the array, just like the list. It may be better on memory though.
- The ghc interpreter is surprisingly capable of doing this.
