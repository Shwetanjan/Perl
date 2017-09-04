#!C\starwberry\perl\bin\perl.exe

#script for virtual restriction digestion of DNA sequeces

sub cleaveAndBind($$$$);

use strict;
use warnings;





my (@dna1, @dna2, $seq, $pos, $i, $ok);
$dna1[0][0] = "5p-sequence-PPPPPP-GAATTC-QQQQQQ-sequence-3p";
$dna1[1][0] = "3p-sequence-QQQQQQ-CTTAAG-PPPPPP-sequence-5p";

$dna2[0][0] = "5p-sequence-XXXXXX-GAATTC-YYYYYY-sequence-3p";
$dna2[1][0] = "3p-sequence-YYYYYY-CTTAAG-XXXXXX-sequence-5p";

$seq = "GAATTC";
$pos = 1;

$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);

$seq = "GAACTT";
$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);


exit;

# Your subroutine must accept all parameters (both 2D arrays and both scalars) as references.

      # you see fit.
sub cleaveAndBind($$$$){

   my @arg1 = shift;
   my @arg1String;
   push(@arg1String,@{$arg1[0][0]});
   push (@arg1String,@{$arg1[0][1]});

   my @arg2 = shift;
   my @arg2String;
   push(@arg2String,@{$arg2[0][0]});
   push (@arg2String,@{$arg2[0][1]});
   #print $arg1String[1],"\n";
   my $restrictionSeq = $_[0];
   my $resSeqStr= $$restrictionSeq;
   my $restrictionPos = $_[1];
   my $resPos= $$restrictionPos;
   #print @arg1,"\n", @arg2, "\n",$restrictionSeq,"\n", $restrictionPos,"\n";
   #print @arg1String,"\n",@arg2String,"\n", $resSeqStr,"\n",$resPos,"\n";
     if (index($arg1String[0],$resSeqStr)!= -1 && index($arg2String[0],$resSeqStr)!= -1){
	 my $arg1lig= substr($arg1String[0],0,index($arg1String[0],$resSeqStr)+$resPos).substr($arg2String[0],index($arg2String[0],$resSeqStr)+$resPos);	
	 my $arg2lig= substr($arg2String[0],0,index($arg2String[0],$resSeqStr)+$resPos).substr($arg1String[0],index($arg1String[0],$resSeqStr)+$resPos);
	 
	# my $arg1rev= reverse($arg1String[1]);
	 #my $arg2rev= reverse($arg2String[1]);
	 
	 my $arg1revlig= reverse(substr(reverse($arg2String[1]),0,index(reverse($arg2String[1]),$resSeqStr)+$resPos).substr(reverse($arg1String[1]),index(reverse($arg1String[1]),$resSeqStr)+$resPos));
	 my $arg2revlig= reverse(substr(reverse($arg1String[1]),0,index(reverse($arg1String[1]),$resSeqStr)+$resPos).substr(reverse($arg2String[1]),index(reverse($arg2String[1]),$resSeqStr)+$resPos));
     #print "true\n";
	 #print $arg1lig,"\n",$arg1revlig,"\n",$arg2lig,"\n",$arg2revlig,"\n\n";
	 @{$arg1[0][0]}=$arg1lig; @{$arg1[0][1]}=$arg1revlig; @{$arg2[0][0]}=$arg2lig;@{$arg2[0][1]}=$arg2revlig;
	 #print @{$arg1[0][0]},"\n",@{$arg1[0][1]},"\n",@{$arg2[0][0]},"\n",@{$arg2[0][1]},"\n";
	 $i="true";
      return($i);
	  }
	  
	  # else {
	  # @{$arg1[0][0]}=$arg1String[0]; @{$arg1[0][1]}=$arg1String[1]; @{$arg2[0][0]}=$arg2String[0];@{$arg2[0][1]}=$arg2String[1];
	  # #print @{$arg1[0][0]},"\n",@{$arg1[0][1]},"\n",@{$arg2[0][0]},"\n",@{$arg2[0][1]},"\n";
	  # $i="false";
	  # }

}
