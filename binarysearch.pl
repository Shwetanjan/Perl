use strict;
use warnings;


# Binary Search Implementation:

sub binarySearch($$);

my ($pos, %numTable, @numArray, $searchKey);

# scalar(keys(%numTable)) => number of keys in the hash table



while(scalar(keys(%numTable)) != 1000) { # fill hash table with random values from 1 to 1000
   $numTable{ int(rand(1000)) + 1 } = "OK";
}

foreach (keys(%numTable)) {    #convert the hash table into array by pushing all the keys into an array#  
   push(@numArray, $_);
}
$searchKey = int(rand(2000));

@numArray = sort {$a <=> $b} @numArray;
$pos = binarySearch(\@numArray, $searchKey);

if($pos != -1) {
   print "found $searchKey at index: $pos [$numArray[$pos]]\n";
}
else {
   print "search key $searchKey NOT found!\n";
}

sub binarySearch($$) {
   my ($arrayRef, $value) = @_;
   my ($low, $high, $mid, $rv, $operationCount);
   $low = $operationCount = 0;
   $high = scalar(@{$arrayRef});  #similar to scalar(@array)
   $rv = -1;
   $mid = int(scalar(@{$arrayRef}) / 2);

   while($low <= $high) {
      print "search key: $value low: $low high: $high mid: $mid\n";
      if($value == $arrayRef->[$mid]) {
         $rv = $mid;
         last;
      }
      elsif($value < $arrayRef->[$mid]) {
         $high = $mid - 1;
         $mid = int(($low + $high) / 2);
      }
      else {
         $low = $mid + 1;
         $mid = int(($low + $high) / 2);
      }
      $operationCount++;
   }
   print "Total binary search operations: $operationCount\n";
   return $rv;
}


