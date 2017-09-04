#!C\starwberry\perl\bin\perl.exe

#script for dot plot based pair-wise alignment of 2 sequences
use strict;
use warnings;

my $hSapien  = <<"END";      
	   1 acatttgctt ctgacacaac tgtgttcact agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagtct gccgttactg ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc actcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgctcggt gcctttagtg atggcctggc tcacctggac aacctcaagg
      301 gcacctttgc cacactgagt gagctgcact gtgacaagct gcacgtggat cctgagaact
      361 tcaggctcct gggcaacgtg ctggtctgtg tgctggccca tcactttggc aaagaattca
      421 ccccaccagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtatca ctaagctcgc tttcttgctg tccaatttct attaaaggtt cctttgttcc
      541 ctaagtccaa ctactaaact gggggatatt atgaagggcc ttgagcatct ggattctgcc
      601 taataaaaaa catttatttt cattgc 
//
END

my $mFascicularis= << "END";     
	   1 acacttgctt ctgacacaac tgtgttcacg agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagaat gccgtcacca ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc tctcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgcttggt gcctttagtg atggcctgaa tcacctggac aacctcaagg
      301 gtacctttgc ccagctcagt gagctgcact gtgacaagct gcatgtggat cctgagaact
      361 tcaagctcct gggcaacgtg ctggtgtgtg tgctggccca tcactttggc aaagaattca
      421 ccccgcaagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtacca ctaagctcac tttcttgctg tccaatttct accaaaggtt cctttgttcc
      541 caaagtccaa ctactgaact gggggatatt atgaagggcc ttgaggatct ggattctgcc
      601 taat
//
END
sub transcribe($){
 my $string =shift(@_);
 $string =~ s/^\s+//;       # remove leading whitespace
 $string =~ s/[0-9]+//g;    # remove numbering 
 $string =~ s/\s+$//g;      # remove trailing whitespace
 $string =~ s/\s*//g;       # remove all embedded whitespace
 $string =~ s/\///g;        #remove all /from the string
 $string =~ s/t/u/g;        # convert T --> U
 $string =~ tr/augc/uacg/;  # convert to the complmentary sequence
 return($string);
 }
 
#Step 1: Convert both DNA sequences (above) to RNA, and then using this hash table:




my $i=0; my $j=0;

my ($hSpString, $mFasString);
my $hSpRna= uc(transcribe($hSapien));
my $mFasRna=uc(transcribe($mFascicularis));
#print "+$hSpRna+\n";
#print "+$mFasRna+\n";


 sub traslation($){
 my %amino = 
   ( AAA=>"K", AAG=>"K",
     GAA=>"E", GAG=>"E",
     AAC=>"N", AAU=>"N",
     GAC=>"D", GAU=>"D",
     ACA=>"T", ACC=>"T", ACG=>"T", ACU=>"T", 
     GCA=>"A", GCC=>"A", GCG=>"A", GCU=>"A",
     GGA=>"G", GGC=>"G", GGG=>"G", GGU=>"G",
     GUA=>"V", GUC=>"V", GUG=>"V", GUU=>"V",
     AUG=>"M",
     UAA=>"*", UAG=>"*", UGA=>"*",
     AUC=>"I", AUU=>"I", AUA=>"I",
     UAC=>"Y", UAU=>"Y",
     CAA=>"Q", CAG=>"Q",
     AGC=>"S", AGU=>"S",
     UCA=>"S", UCC=>"S", UCG=>"S", UCU=>"S",
     CAC=>"H", CAU=>"H",
     UGC=>"C", UGU=>"C",
     CCA=>"P", CCC=>"P", CCG=>"P", CCU=>"P",
     UGG=>"W",
     AGA=>"R", AGG=>"R",
     CGA=>"R", CGC=>"R", CGG=>"R", CGU=>"R",
     UUA=>"L", UUG=>"L", CUA=>"L", CUC=>"L", CUG=>"L", CUU=>"L",
     UUC=>"F", UUU=>"F"
   );
 my $string=shift(@_);
 my $j=0;
 my $protien;
	while (1){
         my $sub=substr($string,$j,3);
		 if (length($sub)<3){
		 last;
		 }
		 $j=$j+3;
		 $protien.=$amino{$sub};
	}
	#$string=$protien;
 return($protien);
 }


 my $hSpProt= traslation($hSpRna);
 my $mFasProt = traslation($mFasRna);

 print "$hSpProt\n";
 print "$mFasProt\n";
 
 my $hSpPlot;
 my $mFasPlot;
 my $dot;
 my $gap;
 my $prot;
 my $space=0;
 my $score=0;
 

 # print "+$hSpProt+\n";
 # print length($hSpProt),"\n";
 # print "+$mFasProt+\n";
 # print length($mFasProt),"\n";
 #open (OUT, "> lab2.txt") ||  warn("Error opening file: dictionary... (must be a permission issue) $!\n");
if (length($hSpProt)<length($mFasProt)){
$prot = length($hSpProt);
}
else {$prot = length($mFasProt);
}
 print " $hSpProt\n";
 while ($i<$prot){
 $hSpPlot=substr($hSpProt,$i,1);
 $mFasPlot=substr($mFasProt,$i,1);
 if ($hSpPlot eq $mFasPlot){
 $dot='X';
 $score=$score+1;
 }
 else{$dot=" "};
 $gap=" "x$space;
 $space++;
 print "$mFasPlot$gap$dot\n"; 
  $i++;
  $j=$i;
 }
 
 if (length($mFasProt)>$prot){
 while ($j<length($mFasProt)){
 print substr($mFasProt,$j,1),"\n";
 $j++;
 }
 }
  my $protSmall;
 if (length($hSpProt)<length($mFasProt)){
 $protSmall = length($hSpProt);
}
else {$protSmall = length($mFasProt);
}
my $perIden= 100*$score/$protSmall;
my $var=sprintf("%.4f",$perIden);
print "percent identity: $var%\n";





 
