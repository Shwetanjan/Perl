#!/usr/bin/perl

use strict;
#use warnings;
use CGI;
use LWP::Simple;

# The Content-type: directive is required by the web-server to tell the
# browser the type of data stream that is being processed!
# The Content-type: directive MUST appear before ANY output and must be
# appended with two (2) newlines!!!

my $cgi = new CGI;
my (@attributes, $result, $tmpAttr, $baseURL, $genbankFile, $virus, $ncbiURL, $rawData);
my (@tmpArray, @genbankData, $start, $i);

@attributes = $cgi->param('attributes');
$virus = $cgi->param('Viruses');

$baseURL = "ftp://ftp.ncbi.nih.gov/genomes/Viruses/";

print "Content-type: text/html\n\n";

print "<html><head><title>Genbank Results...</title></head>\n";
print "<body><pre>\n";

print "Test Genbank solution\n";
print "virus selected is: '$virus'\n";
$ncbiURL = $baseURL . $virus;
print "full URL: $ncbiURL\n";


@tmpArray = split('/', $virus);  # capture the accession number from the string
$genbankFile = $tmpArray[1];     # the 2nd element of the array after the split '/'
print "genbank file to write is: $genbankFile\n";

unless(-e $genbankFile) {
   $rawData = get($ncbiURL); # this function should download the genbank file
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

$result = "";
$start = 1;
$i = 1;

foreach $tmpAttr (@attributes) {
   if($tmpAttr =~ /LOCUS/) {
      $rawData =~ /(LOCUS.*)DEFINITION/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
		      # for the data to be sent by mail
   }
   elsif($tmpAttr =~ /KEYWORDS/) {
      $rawData =~ /(KEYWORDS.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
		      # for the data to be sent by mail
   }
   elsif($tmpAttr =~ /DEFINITION/) {
      $rawData =~ /(DEFINITION.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr =~ /ACCESSION/) {
      $rawData =~ /(ACCESSION.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr =~ /VERSION/) {
      $rawData =~ /(VERSION.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr =~ /SOURCE/) {
      $rawData =~ /(SOURCE.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /ORGANISM/) {
      $rawData =~ /(ORGANISM.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /REFERENCE/) {
      $rawData =~ /(REFERENCE.*?)AUTHORS/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /AUTHORS/) {
      $rawData =~ /(AUTHORS.*?)TITLE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /SOURCE/) {
      $rawData =~ /(SOURCE.*?)ORGANISM/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /TITLE/) {
      $rawData =~ /(TITLE.*?)JOURNAL/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /JOURNAL/) {
      $rawData =~ /(JOURNAL.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /MEDLINE/) {
      $rawData =~ /(MEDLINE.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAtt
      $rawData =~ /(FEATURES.*?)ORIGIN/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /SOURCE/) {
      $rawData =~ /(SOURCE.*?)ORGANISM/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /BASE COUNT/) {
 if  ( $rawData =~ /(BASE COUNT.*?)/s){ print  "$1(",length($1),")\n"
 $result .= $1;  # storing the result in a scalar to allow
}                      # for the data to be sent by mail
else{$rawData =~ /(ORIGIN.*?)\///s;
 $aCount = ()= $rawData =~ /a/g;
$tCount = ()= $rawData =~ /t/g;
$gCount = ()= $rawData =~ /g/g;
$cCount = ()= $rawData =~ /c/g;
print "BASE COUNT $acount A  $tCount T  $gCount G  $cCount T\n"; 
#$result .=

}
elsif($tmpAttr =~ /ORIGIN/) {
      $rawData =~ /(ORIGIN.*?)\///s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /CHECK \/ UNCHECK All/) {
    #  $rawData =~ /(.*?)REFERENCE/s;
      print $rawData ;
      $result .= $rawData;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}


}
my %mail = ( To      => 'danny.arroway@gmail.com',
	     From    => 'my.seneca.id@myseneca.ca',
	     Message => "$result"
	   );

sendmail(%mail) or die $Mail::Sendmail::error;
print "OK! Sent mail message...\n";

print "</pre></body></html>\n";
