-- First argument is the size of the array/list. Second arg, if it
-- exists, switches to the "real" array implementation.

import Data.Array
import System.Environment (getArgs)


doItWithLists :: Int -> IO ()
doItWithLists n =
  let lst = [0..n]    -- At this point the list is lazy. It doesn't really exist.
  in print (lst !! (n-1)) -- This print forces the lst to be created and
                          -- its last element printed.

doItWithArrays :: Int -> IO ()
doItWithArrays n =
  let arr = array (1, n) (zip [1..n] [1..n])
  in  print (arr ! n)


main = do
  args <- getArgs
  let n = read (args !! 0) :: Int
      f = if (length args) > 2
          then doItWithArrays
          else doItWithLists
  f n
  return 0