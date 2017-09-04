use strict;
use warnings;


my %hashTab =(cdg=>"Paris",jfk=>"New York",
                yyz=>"Toronto", lax=>"Los Angeles", yvr=>"Vancouver",
                hkg=>"Hong Kong");

foreach my $key ( keys %hashTab )
{
  print "key: $key, value: $hashTab{$key}\n";
}