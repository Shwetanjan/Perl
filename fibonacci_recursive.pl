
##### Name -Shweta Anjan###
###### 037775152####
##### BIF 724 ###### 
#####LAB A ###############


use strict;
use warnings;

#fibonacci series recursively

sub recursiveBinarySearch($$);

my (@array1, @array2, $rv);
@array1 = (898, 0, 13, 27, -451, 9, 77, 123101, -2, 18);
@array1 = sort {$a <=> $b} @array1;
@array2 = qw(Apple IBM Unix Fibonacci perl bioInformatics Seneca);
@array2 = sort {$a cmp $b} @array2;

# test number search
$rv = recursiveBinarySearch(\@array1, 77);
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";
$rv = recursiveBinarySearch(\@array1, 999);
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";

# test string search
$rv = recursiveBinarySearch(\@array2, "unknown");
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";
$rv = recursiveBinarySearch(\@array2, "Apple");
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";

sub recursiveBinarySearch($$) {
    
   my ($arrayRef, $value) = @_;
   my $isNumber;
   
   print "value = ",$value,"\n";
   my ($low, $high, $mid, $rv, @newArray);
   $low =0;
   $high = scalar(@{$arrayRef});
   print "high = ",$high, "\n";        #similar to scalar(@array)
   $rv = -1;
   
   if ($high == 0){return $rv;}  # check if the array window is reduced to zero, bcoz element is not in the array
   if ( !($arrayRef->[0] & ~ $arrayRef->[0]) )
   {
      # bitwise negation on a member of the array would imply whether the argument to the subroutine is a number or string.
      $isNumber = 1;
   }
   else
   {
      $isNumber = 0;
   }
   
   $mid = int(scalar(@{$arrayRef}) / 2);
   print @{$arrayRef},"\n";
   print "array ref [$mid] = ", $arrayRef->[$mid],"\n";
   print "mid ",$mid,"\n";
   #$operationCount++;
 #  while($low <= $high) {
  #    print "search key: $value low: $low high: $high mid: $mid\n";
  
      
      if($isNumber == 0) {
        # The arg is a string, use the "eq" and "lt" operators to compare the elements.
        if($value eq $arrayRef->[$mid]) {
         $rv = $mid;
         #print "Total binary search operations: $operationCount\n";
         
      }
      
      elsif($value lt $arrayRef->[$mid]) {
      splice(@{$arrayRef},$mid);
      
      $rv = recursiveBinarySearch($arrayRef, $value);
               
      }
      else {
          @newArray=splice(@{$arrayRef},$mid+1);
          print "\$arrayRef = ",@{$arrayRef},"\n";
          print "\@newArray = ",@newArray,"\n";
          $rv = recursiveBinarySearch(\@newArray, $value);
      }
    }
    else
    {
        # The arg is a number, use the "==" and "<" operators to compare the elements.
        if($value == $arrayRef->[$mid]) {
         $rv = $mid;
        # print "Total binary search operations: $operationCount\n";
         
      }
      
      elsif($value < $arrayRef->[$mid]) {
      splice(@{$arrayRef},$mid);
      
      $rv = recursiveBinarySearch($arrayRef, $value);
               
      }
      else {
          @newArray=splice(@{$arrayRef},$mid+1);
          print "\$arrayRef = ",@{$arrayRef},"\n";
          print "\@newArray = ",@newArray,"\n";
          $rv = recursiveBinarySearch(\@newArray, $value);
      }
    }
   return $rv;
}

###########################  LAB B ####################################


sub recursiveFibonacci($);

my @sampleValues = (5, 6, 8, 10);
my $var;

foreach (@sampleValues) {
   print "recursiveFibonacci($_) = ";
   foreach $var (0..$_) {
      print recursiveFibonacci($var);
      print ", " unless $var == $_;
   }
   print "\n";
}

sub recursiveFibonacci($) {
   my ($n, $rv) = shift;
   
   if ($n<=0){$rv = 0;
              return $rv;
             }
   elsif ($n == 1){$rv =1;
                return $rv;
                }
   else{
      $rv = recursiveFibonacci($n-1) + recursiveFibonacci($n-2);
      return $rv;   
   }
}  
