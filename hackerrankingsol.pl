#!C:\strawberry\perl\bin\perl.exe
use strict;
use warnings;

=begin comment
#Q1: 
my ($x,$y,$res,$choice1,$choice2);
sub solveMeFirst{
    ($x,$y) = @_; 
    $res = $x+$y; 
    
    return $res ;   
}


$choice1 = <STDIN> ;
$choice2 = <STDIN> ;
$res = solveMeFirst($choice1 , $choice2);
print "$res" ;

#Q2
my ($n,$i,$array_input,$sum);
chomp($n=<STDIN>);
chomp($array_input = <STDIN>);
my @array=split(" ",$array_input);
 for ($i=0; $i<@array; $i++){
	$sum=$sum+$array[$i];
	}
	
	print "$sum\n";
	
	
	
#Q2:

my ($i, $alice, $bob);
chomp(my $ratingAlice= <STDIN>);
my @arrayAlice = split(" ",$ratingAlice);
$alice=$bob=0;
chomp(my $ratingBob = <STDIN>);
my @arrayBob = split(" ",$ratingBob);

 for ($i=0; $i<scalar(@arrayAlice) || $i<scalar(@arrayBob); $i++){
 if ($arrayAlice[$i]>1 && $arrayAlice[$i]<100 && $arrayBob[$i]>1 && $arrayBob[$i]<100){
 if ($arrayAlice[$i] > $arrayBob[$i]){
  $alice++;
  }
 if  ($arrayAlice[$i] < $arrayBob[$i]){
  $bob++;
  }
 }
 else {
 print "scores not in range\n";
 }
}
	print "$alice $bob\n";

	
#Q4:

print "Entre array size\n";
chomp(my $n = <STDIN>);
my ($i,$sum);
$i=$sum=0;
if ($n> 0 && $n<=10){
start:
chomp(my $inputArray = <STDIN>);
my @array= split(" ",$inputArray);

for ($i=0; $i<@array; $i++){
if ($array[$i]>0 && $array[$i]< 10**10){
$sum= $sum + $array[$i];
}
else{
print "element too big for range reentre values\n";
goto start;
}
}
print "$sum\n";
}
else{
print "size not in range\n";
}



#Q5
my ($row,$i,$mat,$j,$sum,$sum1,$sum2);
$i=$j=$sum=$sum1=$sum2=0;
my @diagnal1=();
my @diagnal2 =();
chomp($row = <STDIN>);
for ($i=0; $i<$row; $i++){
chomp ($mat = <STDIN>);
my @matrixRow = split(" ",$mat,$row);
 push(@diagnal1, $matrixRow[$i]);
  $sum1 = $sum1 + $diagnal1[$i];
  print "$sum1\n";
 $j= $#matrixRow-$i;
 push(@diagnal2, $matrixRow[$j]);
  $sum2 = $sum2 + $diagnal2[$i];
  print "$sum2\n";
  
}
$sum = abs($sum1 + $sum2);
print "$sum\n";
=end comment
=cut
#Q6:

my ($i, $alice, $bob);
chomp(my $num= <STDIN>);
my @array= split(" ",$num);
 for ($i=0; $i<$num; $i++){
  if ($array[$i] > 0){
  $positive++;
  }
 if  ($array[$i] < 0){
  $negative;
  }
 }
 else {
 print "scores not in range\n";
 }
}

