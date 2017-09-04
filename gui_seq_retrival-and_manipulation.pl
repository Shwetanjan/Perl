#!/usr/bin/perl

use lib "/usr/local/share/perl/5.22.1";
use strict;
use Tk;
use warnings;
use CGI;
use DBI;
use CGI;
use LWP::Simple;
use Bio::Restriction::Analysis;
use Bio::PrimarySeq;
require Tk::Dialog;
require Tk::ROText;
use Bio::SimpleAlign;
use Bio::AlignIO;
#use Bio::Tools::dpAlign;
use Mail::Sendmail;
use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator;
use Data::Dumper;
#use Bio::Tools;


my $sampleGenbank = <<'_END_';
LOCUS       SCU49845     5028 bp    DNA             PLN       21-JUN-1999
DEFINITION  Saccharomyces cerevisiae TCP1-beta gene, partial cds, and Axl2p
            (AXL2) and Rev7p (REV7) genes, complete cds.
ACCESSION   U49845
VERSION     U49845.1  GI:1293613
KEYWORDS    .
SOURCE      Saccharomyces cerevisiae (baker's yeast)
  ORGANISM  Saccharomyces cerevisiae
            Eukaryota; Fungi; Ascomycota; Saccharomycotina; Saccharomycetes;
            Saccharomycetales; Saccharomycetaceae; Saccharomyces.
REFERENCE   1  (bases 1 to 5028)
  AUTHORS   Torpey,L.E., Gibbs,P.E., Nelson,J. and Lawrence,C.W.
  TITLE     Cloning and sequence of REV7, a gene whose function is required for
            DNA damage-induced mutagenesis in Saccharomyces cerevisiae
  JOURNAL   Yeast 10 (11), 1503-1509 (1994)
  PUBMED    7871890
REFERENCE   2  (bases 1 to 5028)
  AUTHORS   Roemer,T., Madden,K., Chang,J. and Snyder,M.
  TITLE     Selection of axial growth sites in yeast requires Axl2p, a novel
            plasma membrane glycoprotein
  JOURNAL   Genes Dev. 10 (7), 777-793 (1996)
  PUBMED    8846915
REFERENCE   3  (bases 1 to 5028)
  AUTHORS   Roemer,T.
  TITLE     Direct Submission
  JOURNAL   Submitted (22-FEB-1996) Terry Roemer, Biology, Yale University, New
            Haven, CT, USA
FEATURES             Location/Qualifiers
     source          1..5028
                     /organism="Saccharomyces cerevisiae"
                     /db_xref="taxon:4932"
                     /chromosome="IX"
                     /map="9"
     CDS             <1..206
                     /codon_start=3
                     /product="TCP1-beta"
                     /protein_id="AAA98665.1"
                     /db_xref="GI:1293614"
                     /translation="SSIYNGISTSGLDLNNGTIADMRQLGIVESYKLKRAVVSSASEA
                     AEVLLRVDNIIRARPRTANRQHM"
     gene            687..3158
                     /gene="AXL2"
     CDS             687..3158
                     /gene="AXL2"
                     /note="plasma membrane glycoprotein"
                     /codon_start=1
                     /function="required for axial budding pattern of S.
                     cerevisiae"
                     /product="Axl2p"
                     /protein_id="AAA98666.1"
                     /db_xref="GI:1293615"
                     /translation="MTQLQISLLLTATISLLHLVVATPYEAYPIGKQYPPVARVNESF
                     TFQISNDTYKSSVDKTAQITYNCFDLPSWLSFDSSSRTFSGEPSSDLLSDANTTLYFN
                     VILEGTDSADSTSLNNTYQFVVTNRPSISLSSDFNLLALLKNYGYTNGKNALKLDPNE
                     VFNVTFDRSMFTNEESIVSYYGRSQLYNAPLPNWLFFDSGELKFTGTAPVINSAIAPE
                     TSYSFVIIATDIEGFSAVEVEFELVIGAHQLTTSIQNSLIINVTDTGNVSYDLPLNYV
                     YLDDDPISSDKLGSINLLDAPDWVALDNATISGSVPDELLGKNSNPANFSVSIYDTYG
                     DVIYFNFEVVSTTDLFAISSLPNINATRGEWFSYYFLPSQFTDYVNTNVSLEFTNSSQ
                     DHDWVKFQSSNLTLAGEVPKNFDKLSLGLKANQGSQSQELYFNIIGMDSKITHSNHSA
                     NATSTRSSHHSTSTSSYTSSTYTAKISSTSAAATSSAPAALPAANKTSSHNKKAVAIA
                     CGVAIPLGVILVALICFLIFWRRRRENPDDENLPHAISGPDLNNPANKPNQENATPLN
                     NPFDDDASSYDDTSIARRLAALNTLKLDNHSATESDISSVDEKRDSLSGMNTYNDQFQ
                     SQSKEELLAKPPVQPPESPFFDPQNRSSSVYMDSEPAVNKSWRYTGNLSPVSDIVRDS
                     YGSQKTVDTEKLFDLEAPEKEKRTSRDVTMSSLDPWNSNISPSPVRKSVTPSPYNVTK
                     HRNRHLQNIQDSQSGKNGITPTTMSTSSSDDFVPVKDGENFCWVHSMEPDRRPSKKRL
                     VDFSNKSNVNVGQVKDIHGRIPEML"
     gene            complement(3300..4037)
                     /gene="REV7"
     CDS             complement(3300..4037)
                     /gene="REV7"
                     /codon_start=1
                     /product="Rev7p"
                     /protein_id="AAA98667.1"
                     /db_xref="GI:1293616"
                     /translation="MNRWVEKWLRVYLKCYINLILFYRNVYPPQSFDYTTYQSFNLPQ
                     FVPINRHPALIDYIEELILDVLSKLTHVYRFSICIINKKNDLCIEKYVLDFSELQHVD
                     KDDQIITETEVFDEFRSSLNSLIMHLEKLPKVNDDTITFEAVINAIELELGHKLDRNR
                     RVDSLEEKAEIERDSNWVKCQEDENLPDNNGFQPPKIKLTSLVGSDVGPLIIHQFSEK
                     LISGDDKILNGVYSQYEEGESIFGSLF"
ORIGIN
        1 gatcctccat atacaacggt atctccacct caggtttaga tctcaacaac ggaaccattg
       61 ccgacatgag acagttaggt atcgtcgaga gttacaagct aaaacgagca gtagtcagct
      121 ctgcatctga agccgctgaa gttctactaa gggtggataa catcatccgt gcaagaccaa
      181 gaaccgccaa tagacaacat atgtaacata tttaggatat acctcgaaaa taataaaccg
      241 ccacactgtc attattataa ttagaaacag aacgcaaaaa ttatccacta tataattcaa
      301 agacgcgaaa aaaaaagaac aacgcgtcat agaacttttg gcaattcgcg tcacaaataa
      361 attttggcaa cttatgtttc ctcttcgagc agtactcgag ccctgtctca agaatgtaat
      421 aatacccatc gtaggtatgg ttaaagatag catctccaca acctcaaagc tccttgccga
      481 gagtcgccct cctttgtcga gtaattttca cttttcatat gagaacttat tttcttattc
      541 tttactctca catcctgtag tgattgacac tgcaacagcc accatcacta gaagaacaga
      601 acaattactt aatagaaaaa ttatatcttc ctcgaaacga tttcctgctt ccaacatcta
      661 cgtatatcaa gaagcattca cttaccatga cacagcttca gatttcatta ttgctgacag
      721 ctactatatc actactccat ctagtagtgg ccacgcccta tgaggcatat cctatcggaa
      781 aacaataccc cccagtggca agagtcaatg aatcgtttac atttcaaatt tccaatgata
      841 cctataaatc gtctgtagac aagacagctc aaataacata caattgcttc gacttaccga
      901 gctggctttc gtttgactct agttctagaa cgttctcagg tgaaccttct tctgacttac
      961 tatctgatgc gaacaccacg ttgtatttca atgtaatact cgagggtacg gactctgccg
     1021 acagcacgtc tttgaacaat acataccaat ttgttgttac aaaccgtcca tccatctcgc
     1081 tatcgtcaga tttcaatcta ttggcgttgt taaaaaacta tggttatact aacggcaaaa
     1141 acgctctgaa actagatcct aatgaagtct tcaacgtgac ttttgaccgt tcaatgttca
     1201 ctaacgaaga atccattgtg tcgtattacg gacgttctca gttgtataat gcgccgttac
     1261 ccaattggct gttcttcgat tctggcgagt tgaagtttac tgggacggca ccggtgataa
     1321 actcggcgat tgctccagaa acaagctaca gttttgtcat catcgctaca gacattgaag
     1381 gattttctgc cgttgaggta gaattcgaat tagtcatcgg ggctcaccag ttaactacct
     1441 ctattcaaaa tagtttgata atcaacgtta ctgacacagg taacgtttca tatgacttac
     1501 ctctaaacta tgtttatctc gatgacgatc ctatttcttc tgataaattg ggttctataa
     1561 acttattgga tgctccagac tgggtggcat tagataatgc taccatttcc gggtctgtcc
     1621 cagatgaatt actcggtaag aactccaatc ctgccaattt ttctgtgtcc atttatgata
     1681 cttatggtga tgtgatttat ttcaacttcg aagttgtctc cacaacggat ttgtttgcca
     1741 ttagttctct tcccaatatt aacgctacaa ggggtgaatg gttctcctac tattttttgc
     1801 cttctcagtt tacagactac gtgaatacaa acgtttcatt agagtttact aattcaagcc
     1861 aagaccatga ctgggtgaaa ttccaatcat ctaatttaac attagctgga gaagtgccca
     1921 agaatttcga caagctttca ttaggtttga aagcgaacca aggttcacaa tctcaagagc
     1981 tatattttaa catcattggc atggattcaa agataactca ctcaaaccac agtgcgaatg
     2041 caacgtccac aagaagttct caccactcca cctcaacaag ttcttacaca tcttctactt
     2101 acactgcaaa aatttcttct acctccgctg ctgctacttc ttctgctcca gcagcgctgc
     2161 cagcagccaa taaaacttca tctcacaata aaaaagcagt agcaattgcg tgcggtgttg
     2221 ctatcccatt aggcgttatc ctagtagctc tcatttgctt cctaatattc tggagacgca
     2281 gaagggaaaa tccagacgat gaaaacttac cgcatgctat tagtggacct gatttgaata
     2341 atcctgcaaa taaaccaaat caagaaaacg ctacaccttt gaacaacccc tttgatgatg
     2401 atgcttcctc gtacgatgat acttcaatag caagaagatt ggctgctttg aacactttga
     2461 aattggataa ccactctgcc actgaatctg atatttccag cgtggatgaa aagagagatt
     2521 ctctatcagg tatgaataca tacaatgatc agttccaatc ccaaagtaaa gaagaattat
     2581 tagcaaaacc cccagtacag cctccagaga gcccgttctt tgacccacag aataggtctt
     2641 cttctgtgta tatggatagt gaaccagcag taaataaatc ctggcgatat actggcaacc
     2701 tgtcaccagt ctctgatatt gtcagagaca gttacggatc acaaaaaact gttgatacag
     2761 aaaaactttt cgatttagaa gcaccagaga aggaaaaacg tacgtcaagg gatgtcacta
     2821 tgtcttcact ggacccttgg aacagcaata ttagcccttc tcccgtaaga aaatcagtaa
     2881 caccatcacc atataacgta acgaagcatc gtaaccgcca cttacaaaat attcaagact
     2941 ctcaaagcgg taaaaacgga atcactccca caacaatgtc aacttcatct tctgacgatt
     3001 ttgttccggt taaagatggt gaaaattttt gctgggtcca tagcatggaa ccagacagaa
     3061 gaccaagtaa gaaaaggtta gtagattttt caaataagag taatgtcaat gttggtcaag
     3121 ttaaggacat tcacggacgc atcccagaaa tgctgtgatt atacgcaacg atattttgct
     3181 taattttatt ttcctgtttt attttttatt agtggtttac agatacccta tattttattt
     3241 agtttttata cttagagaca tttaatttta attccattct tcaaatttca tttttgcact
     3301 taaaacaaag atccaaaaat gctctcgccc tcttcatatt gagaatacac tccattcaaa
     3361 attttgtcgt caccgctgat taatttttca ctaaactgat gaataatcaa aggccccacg
     3421 tcagaaccga ctaaagaagt gagttttatt ttaggaggtt gaaaaccatt attgtctggt
     3481 aaattttcat cttcttgaca tttaacccag tttgaatccc tttcaatttc tgctttttcc
     3541 tccaaactat cgaccctcct gtttctgtcc aacttatgtc ctagttccaa ttcgatcgca
     3601 ttaataactg cttcaaatgt tattgtgtca tcgttgactt taggtaattt ctccaaatgc
     3661 ataatcaaac tatttaagga agatcggaat tcgtcgaaca cttcagtttc cgtaatgatc
     3721 tgatcgtctt tatccacatg ttgtaattca ctaaaatcta aaacgtattt ttcaatgcat
     3781 aaatcgttct ttttattaat aatgcagatg gaaaatctgt aaacgtgcgt taatttagaa
     3841 agaacatcca gtataagttc ttctatatag tcaattaaag caggatgcct attaatggga
     3901 acgaactgcg gcaagttgaa tgactggtaa gtagtgtagt cgaatgactg aggtgggtat
     3961 acatttctat aaaataaaat caaattaatg tagcatttta agtataccct cagccacttc
     4021 tctacccatc tattcataaa gctgacgcaa cgattactat tttttttttc ttcttggatc
     4081 tcagtcgtcg caaaaacgta taccttcttt ttccgacctt ttttttagct ttctggaaaa
     4141 gtttatatta gttaaacagg gtctagtctt agtgtgaaag ctagtggttt cgattgactg
     4201 atattaagaa agtggaaatt aaattagtag tgtagacgta tatgcatatg tatttctcgc
     4261 ctgtttatgt ttctacgtac ttttgattta tagcaagggg aaaagaaata catactattt
     4321 tttggtaaag gtgaaagcat aatgtaaaag ctagaataaa atggacgaaa taaagagagg
     4381 cttagttcat cttttttcca aaaagcaccc aatgataata actaaaatga aaaggatttg
     4441 ccatctgtca gcaacatcag ttgtgtgagc aataataaaa tcatcacctc cgttgccttt
     4501 agcgcgtttg tcgtttgtat cttccgtaat tttagtctta tcaatgggaa tcataaattt
     4561 tccaatgaat tagcaatttc gtccaattct ttttgagctt cttcatattt gctttggaat
     4621 tcttcgcact tcttttccca ttcatctctt tcttcttcca aagcaacgat ccttctaccc
     4681 atttgctcag agttcaaatc ggcctctttc agtttatcca ttgcttcctt cagtttggct
     4741 tcactgtctt ctagctgttg ttctagatcc tggtttttct tggtgtagtt ctcattatta
     4801 gatctcaagt tattggagtc ttcagccaat tgctttgtat cagacaattg actctctaac
     4861 ttctccactt cactgtcgag ttgctcgttt ttagcggaca aagatttaat ctcgttttct
     4921 ttttcagtgt tagattgctc taattctttg agctgttctc tcagctcctc atatttttct
     4981 tgccatgact cagattctaa ttttaagcta ttcaatttct ctttgatc
//
_END_

# Main Window
my $mw = new MainWindow(-background =>'white');
$mw->geometry("1000x600");
$mw->resizable(0, 0); # do not allow window to be resized
$mw->title("BIF724 Project....Sequence Manipulation tool");
my $code_font = $mw->fontCreate('code', -family => 'Verdana',
                             -size => 12,
                              -weight => 'bold' );
my $button_font = $mw ->fontCreate('code1', -family => 'Verdana',
                             -size => 10,
                             -weight => 'bold');

# add help menu (with 2 options) to window
$mw->configure(-menu => my $menubar = $mw->Menu);
my $help = $menubar->cascade(-label => 'Help',-font =>'code1');
$help->command(-label=>'Version',
               -command=>sub { $mw->Dialog(-title=>'Project Version...', -text =>'Version 0.1',
                                           -default_button=>'OK')->Show( ); });
$help->command(-label=>'About',
               -command=>sub { $mw->Dialog(-title=>'About...',-font => 'code1', -text =>'The App is meant for
                                           sequence retrival, pair wise alignment and restriction digest analysis.
                                           Functionality:
                                           DISPLAY : will retrive the sequence of interest from NCBI
                                           PSWA: Performs Pair wise Sequence alignment
                                           Provide the accession number for the subject sequence
                                           Provide the sequence to be queried in the sequence section
                                           CLEAVE: Performs restriction digest on the subject sequence with the sequence of interest provided in the sequence section
                                           To restrict your analysis to a defined range of sequences, provide the to and from range in the Query sub range section
                                           Email: Provide your email address to get results emailed to you ',
                                           -default_button=>'OK')->Show( ); });
my ($from, $to);
# main window widgets
my $accession="";
my $accTitle  = $mw->Label(-background => 'white',
                           -font => 'code',
                           -text=>"Enter NCBI accession number...")->place(-x=>110, -y=>5);
my $accLabel  = $mw->Label(-background => 'white',-font => 'code', 
                           -text=>"Accession",) ->place(-x=>10, -y=>25);
my $accEntry  = $mw->Entry(-width=>50, -textvariable=>\$accession)->place(-x=>110, -y=>25);
my $query     = $mw->Label(-background => 'white',-font => 'code',-text=>"Query Subrange...")->place(-x=>615, -y=>5);
my $fromLabel = $mw->Label(-background => 'white',-font => 'code',-text=>"From")->place(-x=>560, -y=>25);
my $fromEntry = $mw->Entry(-textvariable=>\$from)->place(-x=>615, -y=>25);
my $toLabel   = $mw->Label(-background => 'white',-font => 'code',-text=>"To")->place(-x=>585, -y=>50);
my $toEntry   = $mw->Entry(-textvariable=>\$to)->place(-x=>615, -y=>50);

my $resTitle  = $mw->Label(-background => 'white',-font => 'code',-text=>"Enter sequence...")->place(-x=>110, -y=>70);
my $resLabel  = $mw->Label(-background => 'white',-font => 'code',-text=>"Sequence")->place(-x=>15, -y=>90);

my $seqData="";
my $seqFile="";
my $email="";

my $resEntry  = $mw->Entry(-width=>78, -textvariable=>\$seqData)->place(-x=>110, -y=>90);

my $browseButton = $mw->Button(-text => 'Browse...', -font => 'code1',
                               -command => sub { # inline subroutine to read file data
                                                 $seqFile = $mw->getOpenFile( );
                                                 print "seqFile: $seqFile\n";
                                                 $/ = undef;
                                                 open(FD, "< $seqFile");
                                                 $seqData = <FD>;
                                                 $/ = "\n";
                                                 close(FD);
                                               }
                               )->place(-x=>670, -y=>85);
#my $page;
my $seqType = "";
my @options = qw/DISPLAY PWSA CLEAVE/;

my $jobLabel  = $mw->Label(-background => 'white',-font => 'code',-text=>"Function")->place(-x=>15, -y=>130);

my $menu = $mw->Optionmenu(
    -variable => \$seqType,
    -font => 'code1', 
    -options  => [@options],
    -command  => [sub {print "command selected: $seqType\n";}]
    )->place(-x=>110, -y=>130);

# for debug purposes
print "seqType is: $seqType\n";

my $emailLabel  = $mw->Label(-background => 'white',-font => 'code',-text=>"Email")->place(-x=>345, -y=>130);
my $emailEntry  = $mw->Entry(-width=>50, -textvariable=>\$email)->place(-x=>405, -y=>130);

# main output window configured as a scrollable window attached to a new frame
my $textArea = $mw->Frame(-width=>120, -height=>50, -borderwidth=>1, -relief=>'groove')->place(-x=>110,-y=>190);
my $output = $textArea->Scrolled('ROText', -scrollbars=>'se', -height=>25,
                                 -width=>80, -wrap=>'none')->pack(-side=>'left',
                                                                  -pady=>'5',
                                                                  -padx=>'5');
$output->configure(-background => "GREY");
#$output->insert('end', "$sampleGenbank");

my $processButton = $mw->Button(-text=>"Process",-font => 'code1', -command=>\&button1Sub)->place(-x=>720, -y=>190);
my $exitButton    = $mw->Button(-text=>"Exit", -font => 'code1',   -command=>\&button2Sub)->place(-x=>720, -y=>220);

sub button1Sub {
   #my $messageBox = $mw->messageBox(-message=>"Processing...", -type=>"OK");
   #my $answer = $messageBox->Show( );
   #if($answer eq "OK"){
    #print"OKOK\n;";
  # }
    
    if ($seqType eq "DISPLAY"){
        print "accesion : $accession\n";
        getSeq();
    }
                       
   elsif ($seqType eq "PWSA"){
          getPWSA();                   
    }
                       
    elsif ($seqType eq "CLEAVE"){
        getCleave();
    }
                       
    #getSeq();
    
}
sub button2Sub {
   my $dialog = $mw->DialogBox(-title => 'Are you sure?', -buttons => ['Exit', 'Cancel'],
                     -default_button => 'Exit');
   my $answer = $dialog->Show( );
   if($answer eq "Exit") {
      exit;
   }
}




my $cgi = new CGI;

sub getSeq(){
    
    $output->delete('0.0', 'end');    
    $accession= $accEntry ->get();
    $email = $emailEntry ->get();
    print "accession: $accession\n";
    my $page = `curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$accession&rettype=gb"`;
    $output->insert('end', $page);
    email($email,$page);
    
}

sub getPWSA(){
    $output->delete('0.0', 'end');
    my $needle = $resEntry ->get();
    $needle =~ s/^\s+//;      # remove leading whitespace
    $needle =~ s/\"//g;
    print "the seq to match : $needle\n";
     $email = $emailEntry ->get();
    my $page = `curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$accession&rettype=gb"`;
     $page =~ /(ORIGIN.*?)\/\//s;
     my $wholeSeq =$1;
     $wholeSeq=~ s/ORIGIN/ /g;
     $wholeSeq=gbStrEdit($wholeSeq);
     $to =$toEntry ->get();
     $from = $fromEntry ->get();
     
     my $haystack;
            if($to==0 && $from==0){
                $haystack= $wholeSeq;
            }
            else{
                $haystack = substr($wholeSeq,$from-1,$to-$from+1);
            }
                    
#my$factory = Bio::Tools::Run::StandAloneBlast->new(-outfile => 'bl2seq.out');
#my $bl2seq_report = $factory->bl2seq($haystack, $$needle);
#
## Use AlignIO.pm to create a SimpleAlign object from the bl2seq report
#my $str = Bio::AlignIO->new(-file => 'bl2seq.out',
#                        -format => 'bl2seq');
#
#my $aln = $str->next_aln();
#my $inFile = "bl2seq.out";
#open(IN,  "$inFile")    || die("Error: Could not open INPUT  file... '$inFile'  $!\n");
##open(OUT, "> $outFile") || die("Error: Could not open OUTPUT file... '$outFile' $!\n");
#
#$/ = undef;                 # setting the default record separator to undefined
#my $fileData = <IN>;           # slurping entire raw file into a scalar
#close(IN);
#$/ = "\n";                  # resetting default record separator
#
#print $fileData;
     
     my $last= length($haystack)-length($needle);
my $i=0; 
my $haystackSubstring;
my $maxScore =0; my $percentMatch;

my $matchString;
   for ($i=0; $i<=$last;$i++){
	 $haystackSubstring=substr($haystack,$i,length($needle));
      my $j=0; my $match=0;
	  for($j=0;$j<length($needle);$j++){
		  if (substr($haystackSubstring,$j,1) eq substr($needle,$j,1)){
			  $match++;
		  }	
      }
	  
	  if($match>$maxScore){
	  $matchString=$haystackSubstring;
	  $maxScore=$match;
	  #print "$maxScore\n";
	  }
	 # print "$haystackSubstring,$i\n";
}
  
  
  
 $percentMatch= ($maxScore/length($needle))*100;
 print "PairWise Sequence Alignment Report:\n";
 #print "Search Sequence:         \'$needle\'\n";
 #print "Matched Sequence:        \'$matchString\'\n";
 my $var=sprintf("%.4f",$percentMatch);
 print "highest percent identity: $var%\n";
 print "start index:              ",index($haystack,$matchString)+$from,"\n";
 print "end index:                ",index($haystack,$matchString)+length($needle)-1+$from,"\n";
 #print "$bl2seq_report\n";
 my $print1 =index($haystack,$matchString)+$from;
 my $print2 =index($haystack,$matchString)+length($needle)-1+$from;
 #
 #my $matching = substr($haystack,$print1,-10).substr($haystack,$print2,10);
 my $findings= align(lc $needle,lc $haystack);
 my $printing="PairWise Sequence Alignment Report:\n\n".$findings."highest percent identity: $var%\n"."start index:              $print1\n"."end index:                $print2\n";
  # my $findings="PairWise Sequence Alignment Report:\n\nSearch Sequence:         \'$needle\'\nMatched Sequence:        \'$matchString\'\n
   #              PairWise Sequence Alignment:         \\'\n";
  $output->insert('end',$printing);
 
                email($email,$printing);
  
}




sub gbStrEdit($){
 my $string =shift(@_);
 $string =~ s/^\s+//;    # remove leading whitespace
 $string =~ s/[0-9]+//g;  # remove numbering 
 $string =~ s/\s+$//g;   # remove trailing whitespace
 $string =~ s/\s*//g;     # remove all embedded whitespace
 $string =~ s/\///g;     #remove all /from the string
 return($string);
 }
 
sub getCleave(){
    
    $output->delete('0.0', 'end');
    my $needle = $resEntry ->get();
    $email = $emailEntry ->get();
    $needle =~ s/^\s+|\s+$//g;      # remove leading whitespace
   # $needle =~ s/\"//;
    
    #$needle= chomp($needle);
    #$needle = lc($needle);
    print "the seq to match : $needle\n";
    my $page = `curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$accession&rettype=gb"`;
     $page =~ /(ORIGIN.*?)\/\//s;
     my $wholeSeq =$1;
     $wholeSeq=~ s/ORIGIN/ /g;
     $wholeSeq=gbStrEdit($wholeSeq);
     
     $to =$toEntry ->get();
     $from = $fromEntry ->get();
     my $haystack;
            if($to==0 && $from==0){
                $haystack= $wholeSeq;
            }
            else{
                $haystack = substr($wholeSeq,$from-1,$to-$from+1);
            }
     
     #$haystack=lc($haystack);

            
    my $seqObj = Bio::PrimarySeq->new(-seq=>uc $haystack);
            my $re = Bio::Restriction::Enzyme->new(-enzyme=> 'RE', -seq=>uc $needle);
            my $ra = Bio::Restriction::Analysis->new(-seq=>$seqObj,-enzymes=>$re);
            my @fragments = $ra->fragments('RE');
            
            my $findings = "Number of Cleaved Fragments : ". scalar @fragments ."\n\n\n";
            for(my $i=1;$i<=(scalar @fragments);$i++){
                $findings .= "Cleaved fragment $i : length = ".length($fragments[$i-1]). "\n\n";
                $findings .= "1";
                for (my $j=2;$j<length($fragments[$i-1]);$j++){
                    if ($j%60==0){
                        $findings .= $j;
                        $j += length("$j")-1;
                     }
                     else{
                        $findings .= " ";
                      }
                }
                $findings.="\n";
                $findings .= lc($fragments[$i-1]) ."\n\n";
            }   
            
            #$output->delete("1.0",'end');
            $output->insert('end', "$findings");
            email($email,$findings);
    
}

sub email_2($$){
print "AKG> Are we here?\n";
#unshift @{$Mail::Sendmail::mailcfg{'smtp'}} , 'smtp.myseneca.ca';
#print Dumper(\%Mail::Sendmail::mailcfg);

my $to = shift @_;
my $from = 'sanjan@myseneca.ca';
my $subject = 'Test Email';
my $message = shift @_;
 
open(MAIL, "| /usr/sbin/sendmail -t");
 
# Email Header
print MAIL "To: $to\n";
print MAIL "Reply: $from\n";
print MAIL "Subject: $subject\n\n";
# Email Body
print MAIL $message;

close MAIL;
print "Email Sent Successfully\n";
}

#sub email_1($$){
#print "AKG> Are we here?\n";
#unshift @{$Mail::Sendmail::mailcfg{'smtp'}} , 'smtp.myseneca.ca';
#print Dumper(\%Mail::Sendmail::mailcfg);
#
#    my $to = shift @_;
#    my $result= shift @_;
#    print "Mail: $to\n";
#    #print "Result: $result\n";
#    my %mail = ( To   => "$to",
#	     From    => 'sanjan@myseneca.ca',
#	     Message => "$result"
#	   );
#    print "MAIL: ",%mail,"\n";
#
#sendmail(%mail) or die $Mail::Sendmail::error;
#print "OK! Sent mail message...\n";
#
#}

sub align($$){

my $firstsequence = shift @_;
my $secondsequence = shift @_;
my ($match,$mismatch,$gop,$gep,@name_list0,@name_list1,@seq_list0,@seq_list1,@res0,@res1,$len0,$len1,@smat,@tb,@aln0,@aln1);
$match=10;
$mismatch=-10;
$gop=-10;
$gep=-10;

# Read The two sequences from two fasta format file:

#extract the names and the sequences
@name_list0="seq1";
@seq_list0 = $firstsequence;

@name_list1="seq2";
@seq_list1 = $secondsequence;

# get rid of the newlines, spaces and numbers
foreach my $seq (@seq_list0)
	{
	# get rid of the newlines, spaces and numbers
	$seq=~s/[\s\d]//g;	
	}
foreach my $seq (@seq_list1)
	{
	# get rid of the newlines, spaces and numbers
	$seq=~s/[\s\d]//g;	
	}

# split the sequences
for (my $i=0; $i<=$#name_list0; $i++)
	{
	$res0[$i]=[$seq_list0[$i]=~/([a-zA-Z-]{1})/g];
	}
for (my $i=0; $i<=$#name_list1; $i++)
	{
	$res1[$i]=[$seq_list1[$i]=~/([a-zA-Z-]{1})/g];
	}

#evaluate substitutions
$len0=$#{$res0[0]}+1;
$len1=$#{$res1[0]}+1;

for (my $i=0; $i<=$len0; $i++){$smat[$i][0]=$i*$gep;$tb[$i][0 ]= 1;}
for (my $j=0; $j<=$len1; $j++){$smat[0][$j]=$j*$gep;$tb[0 ][$j]=-1;}
	
for (my $i=1; $i<=$len0; $i++)
	{
	for (my $j=1; $j<=$len1; $j++)
		{
		#calcul du score
        my $s;
		if ($res0[0][$i-1] eq $res1[0][$j-1]){$s=$match;}
		else { $s=$mismatch;}
		
		my $sub=$smat[$i-1][$j-1]+$s;
		my $del=$smat[$i  ][$j-1]+$gep;
		my $ins=$smat[$i-1][$j  ]+$gep;
		
		if   ($sub>$del && $sub>$ins){$smat[$i][$j]=$sub;$tb[$i][$j]=0;}
		elsif($del>$ins){$smat[$i][$j]=$del;$tb[$i][$j]=-1;}
		else {$smat[$i][$j]=$ins;$tb[$i][$j]=1;}
		}
	}

my $i=$len0;
my $j=$len1;
my $aln_len=0;

while (!($i==0 && $j==0))
	{
	if ($tb[$i][$j]==0)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==-1)
		{
		$aln0[$aln_len]='-';
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==1)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]='-';
		}
	$aln_len++;
	
	}
#Output en Fasta:
my $end;
$end.= "Matched Sequence:         ";
for ($j=$aln_len-1; $j>=0; $j--){$end.= $aln1[$j];}
$end.= "\n";
$end .="Search Sequence:          ";
for ($i=$aln_len-1; $i>=0; $i--){$end.= $aln0[$i];}
$end.= "\n";



return $end;
}
sub email($$){
my $d = shift @_;
my $results = shift @_;
print "MAIL: $d\n";

if ($d eq ""){return;}
my $ecount = $d =~m/.{1,}@.{1,}\..{2,}/;
my $gemail = Email::Simple->create(
      header => [
          From    => 'gujar.shweta@gmail.com',
          To      => $d,
          Subject => 'Sequence Information',
      ],
      body => $results,
  );

my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'gujar.shweta@gmail.com',
              password => '18anjan%',
          ]
      }
);
if ($ecount==1){
  eval { $sender->send($gemail) };
    }
else{
        my $emailNotValidButton = { $mw->Dialog(-title=>"Invalid Email", -text =>"Invalid Email used",
                                           -default_button=>'OK')->Show( ) };
    }
}
MainLoop;