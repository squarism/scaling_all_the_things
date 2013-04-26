#!/usr/bin/env perl

use Benchmark ':hireswallclock';

if(@ARGV < 1){
  die "Please provide a number for array size (e.g. 1000000)\n";
}

my $num = $ARGV[0];
if($num =~ /[\D]+/){
  die "$num is not a valid integer.\n";
}

my $t0 = new Benchmark;

my @array;
for(my $i=0;$i<$num;$i++){
  $array[$i] = $i;
}

my $t1 = new Benchmark;
my $td = Benchmark::timediff($t1, $t0);
print "Loaded an array with $num elements in:\n" . Benchmark::timestr($td) . "\n";
