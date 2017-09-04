#!/usr/bin/perl
use strict;
#use warnings;
use CGI;
use LWP::Simple;
use Mail::Sendmail;

# The Content-type: directive is required by the web-server to tell the
# browser the type of data stream that is being processed!
# The Content-type: directive MUST appear before ANY output and must be
# appended with two (2) newlines!!!

my $cgi = new CGI;
my ($result, $tmpAttr, $baseURL, $aCount, $tCount, $gCount, 
$cCount, $genbankFile,$tmpBacteria, , $ncbiURL, $rawData, $start, $i);
my (@tmpArray, @genbankData, @bacteria, @attributes);

#@attributes = $cgi->param('attributes');
#$virus = $cgi->param('Viruses');
@bacteria = ("Cephalosporin-resistant Escherichia coli/762041539?report=genbank", "Enterobacter aerogenes/1032322711?report=genbank","Enterobacter cloacae complex/324309273?report=genbank", "Klebsiella pneumoniae/597512677?report=genbank", "Klebsiella oxytoca/55975955?report=genbank");
@attributes = ("LOCUS", "DEFINITION", "ACCESSION", "ORIGIN");
$baseURL = "https://www.ncbi.nlm.nih.gov/nuccore/";

#print "Content-type: text/html\n\n";
#
#print "<html><head><title>Genbank Results...</title></head>\n";
#print "<body><pre>\n";
#
#print "Test Genbank solution\n";
#print "virus selected is: '$virus'\n";


foreach $tmpBacteria(@bacteria) {
   
@tmpArray = split('/', $tmpBacteria);  # capture the bacteria from the string
$genbankFile = $tmpArray[0] . ".gbk";    
$ncbiURL = $baseURL . $tmpArray[1];    # captre the accessiom number and concatinate to get full URL 
print "full URL: $ncbiURL\n";
print "genbank file to write is: $genbankFile\n";

unless(-e $genbankFile) {
   $rawData = get($ncbiURL); # this ifunction should download the genbank file
                             # and store it in the current working directory
   open(FD, "> $genbankFile") || die("Error opening file... $genbankFile $!\n");
   print FD $rawData;
   close(FD);
}

# slurp the genbank file into a scalar!
$/ = undef;
open(FD, "< $genbankFile") || die("Error opening file... $genbankFile $!\n");
$rawData = <FD>;
close(FD);

#$result = "";
#$start = 1;
#$i = 1;

foreach $tmpAttr (@attributes) {
   if($tmpAttr == "LOCUS") {
     # print $rawData;
      $rawData =~ /(LOCUS.*)DEFINITION/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
		      # for the data to be sent by mail
   }
  
   elsif($tmpAttr == "DEFINITION") {
      
      $rawData =~ /(DEFINITION.*?)ACCESSION/s;
      print "$1";
      #$result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr == "ACCESSION") {
   
      $rawData =~ /(ACCESSION.*?)VERSION/s;
      print "$1";
      #$result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }

elsif($tmpAttr == "ORIGIN") {
   
      $rawData =~ /(ORIGIN.*?)\/\//s;
      print "$1";
      #$result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
}

}
