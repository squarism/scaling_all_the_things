#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <limits.h>
#include <errno.h>

/*
 *
 * 1) Added command line argument capability.
 * 2) Calculating elapsed time in millis.
 *
 * */

int main(int argc, char *argv[])
{
  int base;
  char *endptr, *str;
  unsigned long long max;

  if (argc < 2) {
      fprintf(stderr, "Usage: %s str [base]\n", argv[0]);
      exit(EXIT_FAILURE);
  }

  str = argv[1];
  base = (argc > 2) ? atoi(argv[2]) : 10;

  errno = 0;
  max = strtol(str, &endptr, base);

  if ((errno == ERANGE && (max == LONG_MAX || max == LONG_MIN))
          || (errno != 0 && max == 0)) {
      perror("strtol");
      exit(EXIT_FAILURE);
  }

  if (endptr == str) {
      fprintf(stderr, "No digits were found\n");
      exit(EXIT_FAILURE);
  }

  if (*endptr != '\0')        /* Not necessarily an error... */
      printf("Further characters after number: %s\n", endptr);

  struct timeval tim;
  gettimeofday(&tim, NULL);
  double t1=tim.tv_sec+(tim.tv_usec/1000000.0);

  unsigned long long *array;
  array = malloc(max * sizeof(unsigned long long));
  unsigned long long i;
  for(i=0;i<max;i++){
    array[i] = i;
  }
  free(array);

  gettimeofday(&tim, NULL);
  double t2=tim.tv_sec+(tim.tv_usec/1000000.0);

  printf("Loaded %lu elements into an array in %.6lf seconds.\n", max, t2-t1);

  exit(EXIT_SUCCESS);
}
