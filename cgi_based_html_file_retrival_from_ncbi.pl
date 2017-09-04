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
my (@attributes, $result, $tmpAttr, $baseURL, $aCount, $tCount, $gCount, 
$cCount, $genbankFile, $virus, $ncbiURL, $rawData);
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
      $rawData =~ /(KEYWORDS.*?)SOURCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
		      # for the data to be sent by mail
   }
   elsif($tmpAttr =~ /DEFINITION/) {
      $rawData =~ /(DEFINITION.*?)ACCESSION/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr =~ /ACCESSION/) {
      $rawData =~ /(ACCESSION.*?)VERSION/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
   }
elsif($tmpAttr =~ /VERSION/) {
      $rawData =~ /(VERSION.*?)DBLINK/s;
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
      $rawData =~ /(REFERENCE.*AUTHORS)/s;

    my $BigChunk=$1; my $lenOfBigChunk = length($1);
    while ($BigChunk ne '') {
      if($BigChunk =~ /(REFERENCE.*?)AUTHORS/s) {
          print "$1" if ($1 =~ /(REFERENCE.*?)CONSRTM/s); 
        print "$1";
        $result .= $1;  # storing the result in a scalar to allow
                       # for the data to be sent by mail
        $BigChunk =~ s/\Q$1\E//s;
      }
      else {
        last;
      }
    }  
}

elsif($tmpAttr =~ /AUTHORS/) {
      $rawData =~ /(AUTHORS.*TITLE)/s;

    my $BigChunk=$1; my $lenOfBigChunk = length($1);
    while ($BigChunk ne '') {
      if($BigChunk =~ /(AUTHORS.*?)TITLE/s) {
        print "$1";
        $result .= $1;  # storing the result in a scalar to allow
                        # for the data to be sent by mail
        $BigChunk =~ s/$1//s;
      }
      else {
        last;
      }
    }
}
elsif($tmpAttr =~ /SOURCE/) {
      $rawData =~ /(SOURCE.*?)ORGANISM/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}

elsif($tmpAttr =~ /TITLE/) {
      $rawData =~ /(TITLE.*JOURNAL)/s;

    my $BigChunk=$1; my $lenOfBigChunk = length($1);
   
    while ($BigChunk ne '') {
      if($BigChunk =~ /(TITLE.*?)JOURNAL/s) {
        print "$1";
        $result .= $1;  # storing the result in a scalar to allow
                        # for the data to be sent by mail
        $BigChunk =~ s/$1//s;
      }
      else {
        last;
      }
    }
}


elsif($tmpAttr =~ /JOURNAL/) {
      $rawData =~ /(JOURNAL.*COMMENT)/s;

    my $BigChunk=$1; my $lenOfBigChunk = length($1);
    my @regex = ('PUBMED','REFERENCE','COMMENT');
   
    foreach(@regex) {
      while ($BigChunk =~ /(JOURNAL.*?)$_/s) {
          if ($1 =~ /(JOURNAL..*?)REMARK/s) {
            print "$1";
            $result .= $1;  # storing the result in a scalar to allow
                            # for the data to be sent by mail
            $BigChunk =~ s/\Q$1\E//s;
            next;
          }
          print "$1";
          $result .= $1;  # storing the result in a scalar to allow
                          # for the data to be sent by mail
          $BigChunk =~ s/\Q$1\E//s;
      }
    }
}

elsif($tmpAttr =~ /MEDLINE/) {
      $rawData =~ /(PUBMED.*?)REFERENCE/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /FEATURES/) {
      $rawData =~ /(FEATURES.*?)ORIGIN/s;
      print "$1";
      $result .= $1;  # storing the result in a scalar to allow
                      # for the data to be sent by mail
}
elsif($tmpAttr =~ /BASE COUNT/) {
  if  ( $rawData =~ /(BASE COUNT.*?)/s) {
    print  "$1";
    $result .= $1;  # storing the result in a scalar to allow
  }                      # for the data to be sent by mail
  else {
    $rawData =~ /(ORIGIN.*?)\/\//s;
    $aCount = ()= $1 =~ /a/g;
    $rawData =~ /(ORIGIN.*?)\/\//s;
    $tCount = ()= $1 =~ /t/g;
    $rawData =~ /(ORIGIN.*?)\/\//s;
    $gCount = ()= $1 =~ /g/g;
    $rawData =~ /(ORIGIN.*?)\/\//s;
    $cCount = ()= $1 =~ /c/g;
    print "BASE COUNT $aCount A  $tCount T  $gCount G  $cCount C"; 
    $result .= "BASE COUNT $aCount A  $tCount T  $gCount G  $cCount C";
  }
}
elsif($tmpAttr =~ /ORIGIN/) {
      $rawData =~ /(ORIGIN.*?)\/\//s;
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
my $mailTo = $cgi->param('Email');
my $mySenecaId = 'sanjan@myseneca.ca';

my %mail = ( To      => $mailTo,
	     From    => $mySenecaId,
             Subject => 'Assignment#2 email',
	     Message => "$result"
	   );
#$mail{Smtp} = 'localhost';

sendmail(%mail) or die $Mail::Sendmail::error;

print "OK! Sent mail message...\n";

print "</pre></body></html>\n";
