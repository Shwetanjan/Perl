
use strict;
use warnings;

#decode the matirx to get the pairewise alignment

my $xAxisString = "trxme wspg phsna";
my $yAxisString = "pduapzic abchozy";

my @matrix = ( [0,   -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, -13, -14, -15, -16],
               [-1,   0,  2,  0,  1,  0,  1,  0,  0,  0,  1,    0,   2,   0,   0,   1,   2],
               [-2,   3,  0,  0,  0, -2,  2,  0,  0,  0,  0,    0,   1,   0,   0,   0,   0],
               [-3,   0,  0, -1,  0,  0,  1,  0,  0,  0,  2,    0,  -1,   0,   0,  -1,   1],
               [-4,   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,    0,   0,  -1,   0,   0,   0],
               [-5,   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,    0,   2,   0,   0,   3,   0],
               [-6,   3,  0,  1, -1,  0,  0,  0,  0,  0, -1,    0,   0,   0,   1,   2,   0],
               [-7,   2,  2,  0,  4,  1,  1,  0,  0,  0,  0,    0,   1,   0,   0,   0,   2],
               [-8,   0,  1,  0, -1,  3,  1,  0,  0,  0,  1,    0,  -1,   0,   0,   0,  -1],
               [-9 ,  1,  0,  0,  0,  0, -1,  2, -1,  0,  0,    0,   2,   0,   0,   0,   0],
               [-10,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,    0,   1,   0,   0,   0,   1],
               [-11,  0, -1,  0,  0,  0,  0, -1,  2,  0, -1,   -2,  -1,   0,   0,   0,   0],
               [-12,  0,  1,  0, -2,  0,  0,  0,  0, -1,  1,    0,   1,   0,   0,   0,   2],
               [-13,  0,  0,  0, -1,  0,  0,  0,  0,  0,  0,   -2,   0,  -1,  -3,  -2,   1],
               [-14,  0,  2,  0,  0,  0,  0, -1,  0,  0,  0,    0,  -1,   0,  -1,   1,   0],
               [-15, -1,  0,  0,  1,  0,  0,  1,  0,  0,  0,    0,   0,   0,   0,   1,   0],
               [-16,  0, -1,  0,  1,  0,  0,  2,  0,  0,  0,    0,   0,   0,   0,  -2,   0]
             );
my $string = decodeMatrix(\@matrix,$xAxisString, $yAxisString);

print "$string\n";
sub decodeMatrix {
    my ($mat, $xstring, $ystring)= @_;
    my ($i,$len,$x,$y);
    my $temp;
    chomp($xstring);
    chomp($ystring);
    
    if (length($xstring)>length($ystring)){
         $len = length($xstring);
    }
    else {
         $len = length($ystring);
    }
    $x=$y=$len;
       
    for($i=$len,$i<=0, $i--){
        
        if ($mat->[$i-1][$i] > $mat->[$i-1][$i-1] && $mat ->[$i-1][$i] > $mat->[$i][$i-1]){
           $temp = $temp . substr($xstring,$i,1);
        }
        elsif ($mat->[$i][$i-1] > $mat->[$i-1][$i-1] &&  $mat->[$i][$i-1] > $mat->[$i-1][$i]){
           $temp = $temp . substr($ystring,$i,1);  
        }
        elsif ($mat->[$i-1][$i-1] > $mat->[$i][$i-1] && $mat->[$i-1][$i-1] > $mat->[$i-1][$i]){
            if (ord(substr($xstring,$i,1)) > ord(substr($ystring,$i,1))){
                $temp = $temp . substr($xstring,$i,1);
            }
             else{
                $temp = $temp . substr($ystring,$i,1);
             }    
        }
    }        
   return($temp); 
}  
