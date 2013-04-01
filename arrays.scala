import scala.collection.mutable.ArrayBuffer

object ArrayTest {
  def main(args: Array[String]) {

    // command line argument
    val num = args(0).toInt

    // ArrayBuffer is too slow
    val array = new Array[Int](num)

    val startTime = java.lang.System.currentTimeMillis()

    // loop specified number of times and append
    (0 to num - 1).par.foreach { i =>
      array(i) = i
    }

    val endTime = java.lang.System.currentTimeMillis()

    val elapsed = endTime - startTime

    // date formatter with timezone correction
    val df = new java.text.SimpleDateFormat("HH:mm:ss:SSSS")
    df.setTimeZone(java.util.TimeZone.getTimeZone("GMT"))
    val timeComponents = df.format(elapsed).split(":")

    val hours        = timeComponents(0)
    val minutes      = timeComponents(1)
    val seconds      = timeComponents(2)
    val milliseconds = timeComponents(3)

    // val size = "%,d".format(array.size)
    val size = "%,d".format(array.size)
    println(s"Done. Array size is $size")
    println(s"Time: $hours hours, $minutes minutes, $seconds seconds, $milliseconds milliseconds")

  }
}


/*
# had to increase memory, couldn't run these on my laptop
# export JAVA_OPTS="-Xmx2g"

Done. Array size is 1,000,000
Time: 00 hours, 00 minutes, 00 seconds, 0042 milliseconds

Done. Array size is 10,000,000
Time: 00 hours, 00 minutes, 00 seconds, 0134 milliseconds

Done. Array size is 100,000,000
Time: 00 hours, 00 minutes, 01 seconds, 0050 milliseconds

# had to increase memory again to 8GB, had to run on Mac Pro
Done. Array size is 1,000,000,000
Time: 00 hours, 00 minutes, 09 seconds, 0564 milliseconds
*/
