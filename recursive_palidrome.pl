#!/usr/bin/perl -w
use strict;
#Recursive functional subroutine#

use warnings;

sub isPalindrme($);
my $seq;

print "Enter a sample palindromic sequence...";
chomp($seq = <STDIN>);

sub isPalindrome($){
    my ($string, $len) = shift;
    $len = length($string);
    
    if($len > 2) {#base case
        if(substr($string,0,1) eq substr($string,-1,1)){
            
        }
}

