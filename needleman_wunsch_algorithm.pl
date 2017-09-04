use strict;
use warnings;

#Finding the best possible alignment (i.e. the alignment that implies the fewest
#number of mutations) for 2 sequences can be achieved by using the
#Needleman-Wunsch (N-W) algorithm.


my (@NWmatrix, $seq1, $seq2, $gap, $match, $mismatch);
my ($xgap,$ygap,$xy,$n,$m,$x, $rv, $y, $i, $j);
$seq1 = "ACTGATTCA";
$seq2 = "ACGCATCA";

$gap = -2;
$i=0;
$m=length($seq1);
#print "$x\n";
print "$m\n";
$n=length($seq2);
#print "$y\n";
print "$n\n";

sub recursive ($$);

$NWmatrix[0][0]= 0;
#print " $NWmatrix[0][0]";
for ($x=0;$x<=$m; $x++){
    $NWmatrix[0][$x] = $x * $gap;
    print " $NWmatrix[0][$x]";
}
print "\n";
$x=1;
 for ($y=1; $y<$n+1; $y++){
     $NWmatrix[$y][0] = $y * $gap;
     print "$NWmatrix[$y][0]";
     #$xgap=$ygap=$xy=0;
   
#     #for($i=1; $j<$j+1; $j++){}
     $rv = recursive($y,$x);
     print "\n";
}
 
 
    sub recursive ($$) {
        my  ($ys,$xs)= @_;
    #my ($i,$j, $xs, $ys,$xgap,$ygap,$xy,$rv, $gaps);
  $match = 1;
  $mismatch = -1;
  $gap= -2;
#   $xs=length($s1);
#   $ys=length($s2);
#      
         $xgap = $NWmatrix[$ys-1][$xs] + $gap;
         $ygap = $NWmatrix[$ys][$xs-1] + $gap;
        if (substr($seq1,$xs-1,1) eq substr($seq2,$ys-1,1)){
            $xy=$NWmatrix[$ys-1][$xs-1] + $match;
        }
        else{
            $xy=$NWmatrix[$ys-1][$xs-1] + $mismatch;
        }
        
        if ($xgap >= $ygap && $xgap >= $xy){
             $NWmatrix[$ys][$xs]=$xgap;           
             #print $xgap;
        }
        elsif ($ygap >= $xgap && $ygap >= $xy){
            $NWmatrix[$ys][$xs]=$ygap;
            #print $ygap;
        }
       elsif ($xy >= $xgap && $xy >= $ygap){
            $NWmatrix[$ys][$xs]=$xy;
#            #print $xy;
       }
      print " $NWmatrix[$ys][$xs]";
#       
       if($xs<$m) {
      $rv= recursive ($ys,$xs+1);
       }
      else{
        return $rv;
       }
}


sub max ($){
    
}
#
#
##my $str = "abcd";
##my $n =1;
##my $i=0;
##while ($n>0){
##    my $sub= substr($str, $i);
##    print "$sub\n";
##     $n=length($sub);
##     $i++
##}
###print @{NWmatrix};
#
#
#recursive(..) {
#    return max(recursive(substr($s1 - 1), substr($s2 - 1), ))
#}
