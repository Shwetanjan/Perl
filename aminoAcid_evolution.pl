#!C\starwberry\perl\bin\perl.exe
use strict;
use warnings;

my ( $H, $O, $N, $C, $MW, $bond, $aminoAcid, $Y, $ranNum, $openElement,$aminoName); 
$H = $O = $N = $C = $MW = $bond = $ranNum= $Y = $aminoAcid = $openElement = $aminoName = 0;    # openElement is 0 initally updates to the element open to bond with  
																							   #which the incoming element will bond 
for ($Y=0, $aminoAcid=0;$Y < 3800000000.0 && $aminoAcid == 0; $Y++) 
{
    $ranNum = int(rand(4)+1);
   # print "random number is :$ranNum, the bond is: $bond\n";
   # print "$Y\n";
	
    if ($ranNum == 1 ){                                                           # Hydrogen atom logic
        $H++;
	    $MW = $MW + 1.0079;
		$bond += 1;
	}
	
	elsif ($ranNum == 2){
	    $O++;
		$MW = $MW + 15.9994;
		if($bond >= 0){                                                           # Oxygen atom logic, oxygen valency -2;  
		    $bond -= 2;					                                          # as one atom wil be used to form bonds with the existing atom
		}                                                                         # the existing valence of the compound is 0 or more,oxygen will increase the valancy by -2
	   else{                                                                      #oxygen will not bond with nitrogen as there is no amino acid with a N-O bond
	       if ($openElement == 3){                                                 #thus when open elemne t=3=nitorgen no bonds ae formed eaction starts over
		       $H = $O = $N = $C =$bond = $MW = 0;                                #in case of openelement being carbon =4; oxygen forms a double bond when more that two open bonds are present
		   }
		   elsif($openElement == 4 && $bond <-2){
		       $bond += 2;
			}
       }
    }	                                                                          
	                                                                             
	
	elsif ($ranNum == 3){					                                      # Nitrogen atom logic, nitrogen valency -3; 
	    $N++;
		$MW = $MW + 14.0067;
		if($bond >= 0){                                                           # nitrogen will increase the valency  by -3 only when the existing valency id 0 or more;
		$bond -= 3;
		}
		else{   
            if ($openElement == 2){                                               # nitrogen wil not bond with oxygen                           
			$H = $O = $N = $C =$bond = $MW = 0;
			}	 	                                                              
		    else{                                                                 # In case the valency is less than 0 nitrogen will decrease the total valency by 1;
		    $bond -= 1;                                                           # as one atom wil be used to form bonds with the existing atom
		    }
	   }
	}
	
	elsif ($ranNum == 4){                                                          # Carbon atom logic: valency =-4; when bond value is 0 or more except                                                              
	    $C++;                                                                     # for when carbon atom is not the 3rd carbon atom
		$MW += 12.0107;
		
		if ($C % 3 == 0 ){	
			if ($bond >= 0){                                                      # In case of carbon atom is the 3rd carbon atom the valency wil reduce by a factor of only 2
		    $bond -= 2; 
			}                                                                     # because of the double bond formation by the 3rd carbon 
		}
		
		elsif ($bond >= 0){                                                       # for all other carbon atoms the bond value will reduce by -4 for positive bond value   
		    $bond -= 4;
		}
		else {                                                                    # for a negative bond value the net bond value after adding a carbon atom decreases  by 2
		    $bond -= 2;                                                           # as one atom wil be used to form bonds with the existing atom
		}
	}
    
	if ($bond < -4){                                                             # when bond value ges below -4 hydrogen atoms are added
	    $H += 3;
		$MW = $MW + (3*1.0079);
		$bond += 3;
	}
	print "the bond is: $bond\n";
	$openElement = $ranNum;
	if ($bond == 0){
	    
		print "Stable compound C$C H$H N$N O$O was found, molecular weight: $MW\n";
		
		#if ($MW == 75.0664)                                                           # alternatively the if statement can also be checked by weight
		 if ($C==2 && $H == 5 && $N ==1 && $O == 2){
        	$aminoName = "Glycine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 89.0929){
		elsif ($C==3 && $H == 7 && $N ==1 && $O == 2){
			if ($MW > 90){  
               $aminoName = "Cysteine";                                 			# The presence of Sulphur in this Amino acid makes it heavier than Alanine, 
		       }                                                                     # which we can use to differentiate b/w the two
			else{
			    $aminoName = "Alanine";
				
			}
			$aminoAcid = 1;
		}
			
		#elsif ($MW == 105.0923)                                              
		elsif ($C==3 && $H == 7 && $N ==1 && $O == 3){
		    $aminoName = "Serine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 115.1301) 
		elsif ($C==5 && $H == 9 && $N ==1 && $O == 2){
			$aminoName = "Proline";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 117.1459) 
		elsif ($C==5 && $H == 11 && $N ==1 && $O == 2){
		    if ($MW > 118){
			    $aminoName = "Methionine";
			}
			else{
			    $aminoName = "Valine";
			}
		    $aminoAcid = 1;
		}
		
		#elsif ($MW == 119.1188) 
		elsif ($C==4 && $H == 9 && $N ==1 && $O == 3){
			$aminoName = "Threonine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 131.1724) 
		elsif ($C==6 && $H == 13 && $N ==1 && $O == 2){
		    $aminoName = "Leucine or Isoluecine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW ==132.1172 ) {
		elsif ($C==4 && $H == 8 && $N ==2 && $O == 3){
		    $aminoName = "Aspergine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 133.1024) {
		elsif ($C==4 && $H == 7 && $N ==1 && $O == 4){
			$aminoName = "Aspartic acid";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 146.1441) {
		elsif ($C==5 && $H == 10 && $N ==2 && $O == 3){
            $aminoName = "Glutamine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 146.1870) {
		elsif ($C==6 && $H == 14 && $N ==2 && $O == 2){
		    $aminoName = "Lysine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 147.1289) {
		elsif ($C==5 && $H == 9 && $N ==1 && $O == 4){
			$aminoName = "Glutamic acid";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 149.2109) {
		#elsif ($C==5 && $H == 11 && $N ==1 && $O == 2){
			# Account for Sulphur (like Cysteine)
		#	$aminoName = "Methionine";
		#	$aminoAcid = 1;
		#}
		#elsif ($MW == 155.1542) {
		elsif ($C==6 && $H == 9 && $N ==3 && $O == 2){
			print "Histidine (MW = $MW) formed after $Y years!\n";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 165.1887) {
		elsif ($C==9 && $H == 11 && $N ==1 && $O == 2){
			$aminoName = "Phenylalaine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 174.2004) {
		elsif ($C==6 && $H == 14 && $N ==4 && $O == 2){
			$aminoName = "Arginine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 181.1881) {
		elsif ($C==9 && $H == 11 && $N ==1 && $O == 3){
		    $aminoName = "Tyrosine";
			$aminoAcid = 1;
		}
		
		#elsif ($MW == 204.2241) {
		elsif ($C==11 && $H == 12 && $N ==2 && $O == 2){
            $aminoName = "Tryptophan";
			$aminoAcid = 1;
		}
		
		elsif($MW > 305) {
			$H = $O = $N = $C =$bond = $MW = 0;
			print "After $Y years molecule formed too big to be an amoino acid\n";
		}
	}
} 
if ($aminoAcid == 1){
    print "Hurray you found $aminoName, in $Y years, molecular weight is $MW\n";
}
else{
    print "After $Y years no amino acid formed!\n";
	}


system("pause");	



=begin comment
1.  Was an amino acid ever produced?
ans: yes
1a. If so, which one?
ans: during the first set of runs the common ones were Glycine, Alanine and Serine
1b. If an amino acid was produced, how many years did it take to form?
ans: lysine in 1456 years
1c. If more than 1 amino acid was produced (multiple program runs)
    what was the average time required to generate these?
ans: 500 iterations took 7.63 secs, it produced 
     
2.  Based on the results of your program, what can you determine
    regarding the probability of the building blocks of life being
    created from primordial elements?
ans: Acoording to the program the even randomly assembig molecules can generate amino acids. Thus there is a high
     propability that random events that brought together primordial elemnents gave rise to building blocks of life.
	 
3.  If your program does generate amino acids, is there any correlation
    between those most frequently produced (or generated first) and
    the complexity (number of atoms) in the amino acid?
ans: 5000 iteratins of the program generated the following results
	Glycine			C2H5NO2		75.0664		1190
	Alanine			C3H7NO2		89.0929		1089
	Serine			C3H7NO3		105.0923	745
	Proline			C5H9NO2		115.1301	249
	Valine			C5H11NO2	117.1459	217
	Threonine		C4H9NO3		119.1188	296
	Cysteine*		C3H7NO2S	121.1579	0
	Isoleucine		C6H13NO2	131.1724	66
	Leucine			C6H13NO2	131.1724	66
	Asparagine		C4H8N2O3	132.1176	274
	Aspartic acid	C4H7NO4		133.1024	227
	Glutamine		C5H10N2O3	146.1441	203
	Lysine			C6H14N2O2	146.187		98
	Glutamic acid	C5H9NO4		147.1289	152
	Methionine*		C5H11NO2S	149.2109	0
	Histidine		C6H9N3O2	155.1542	38
	Phenylalanine	C9H11NO2	165.1887	7
	Arginine		C6H14N4O2	174.2004	140
	Tyrosine		C9H11NO3	181.1881	12
	Tryptophan		C11H12N2O2	204.2247	0
	
	The above result shows that as the molecular weight and the structural complexity of 
	the amino acid incease the probability of their formatio  decrease. An the probaility of formation of 
	amino acids with similar structure and weight is also same eg: Valine and threonine are structurally similar
	and the number of times they have been detected is similar.
	As tryptophan has 11 C the probability of finding it at 5000 runs is low.. this probabilty will increase with the increase in the number 
	of runs.
	
	
4.  How can you change your program to allow more complex amino
    acids to be produced? Try this and observe the results making a
    note as to any correlation you find!
ans: To get complex amino acids like the ring structured ones, adding additional constarints to the double bond formation
	 or by putting additional clause for the of the incoming amino acid to bond to the existing one can improve the probability
	 of finding the bulkier amino acids.
	 for cysteine and methionine variables or S has to be added.
=end comment
=cut	