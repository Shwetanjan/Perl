#!/usr/bin/perl

use lib "/usr/local/share/perl/5.22.1";
#use strict;
use Tk;
use warnings;
use CGI;
#use DBI;
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
use Bio::Tools::Run::StandAloneBlast;
use Bio::SeqIO;
use Bio::AlignIO::bl2seq;
  
  my $rawSeq1= "gcatcagactacgcatacgacgacagacagacatcggtcggacagatacagatcctcgacagctag";
  my $rawSeq2= "aaaccacagtgcgaatgcaacgtccacaagaagtt";
  
  #my $seq1 = Bio::Seq->new(-seq => $rawSeq1);
  #my $seq2 = Bio::Seq->new(-seq => $rawSeq2);
  
  #my $in  = Bio::AlignIO->new(-file => "/home/shweta/Documents/Seneca2017/Perl_Programming/bl2seq.txt" ,
  #                         -format => 'fasta');
  #my $out = Bio::AlignIO->new(-file => ">/home/shweta/Documents/Seneca2017/Perl_Programming/bl2out.txt",
  #                         -format => 'emboss');
  
  open MYIN, '<', 'bl2seq.fasta' or die "Could not read file 'testaln.fasta': $!\n";
my $in  = Bio::AlignIO->newFh(-fh     => \*MYIN,
                           -format => 'fasta');
open my $MYOUT, '>', 'bl2out.txt' or die "Could not write file 'testaln.pfam': $!\n";
my $out = Bio::AlignIO->newFh(-fh     =>  $MYOUT,
                           -format => 'clustalw');
 
# World's smallest Fasta<->pfam format converter:b
print $out $_ while <$in>;

#while ( my $aln = $in->next_aln() ) { $out->write_aln($aln); }