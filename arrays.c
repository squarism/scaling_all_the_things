#include <stdlib.h>
#include <stdio.h>
#include <time.h>
/*
 * TODO:
 * 1) Add command line argument capability.
 * 2) Calculate time in millis.
 *
 * */

int main (int argc, char* argv[]) {
  unsigned long max = atoi(argv[1]);

  time_t start_time, end_time;
  char* c_time_string;

  start_time = time(NULL);

  unsigned long *array;
  array = malloc(max * sizeof(unsigned long));
  unsigned long i;
  for(i=0;i<max;i++){
    array[i] = i;
  }
  free(array);

  end_time = time(NULL);
  c_time_string = ctime(&start_time);
  printf("Start time: %s", c_time_string);
  c_time_string = ctime(&end_time);
  printf("  End time: %s", c_time_string);
  double diffs = difftime(end_time, start_time);
  printf("Loaded %lu elements into an array in %f seconds.\n", max, diffs);
}