package main

import (
    "flag"
    "fmt"
    "os"
    "strconv"
)

func main() {
  flag.Parse()
  s := flag.Arg(0)

  // string to int
  num, err := strconv.Atoi(s)
  if err != nil {
      // handle error
      fmt.Println(err)
      os.Exit(2)
  }

  var array []uint32
  for i := 0; i < num; i++ {
    array = append(array, uint32(i))
  }

  fmt.Println(len(array))
}