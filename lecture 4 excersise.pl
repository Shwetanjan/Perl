#!C:\strawberry\perl\bin\perl.exe
use strict;
use warnings;

# Q1a: Store all the months of the year in an array variable called "months
# Q1c:Display only the second, fifth, and tenth month to the screen each separated by a single space
#Q1d:Display the months on the screen backwards.
# Q1e:Display the number of elements contained in the array "months".
#Q1f: Add the element "new-year" to the months array.
# Q1g:Sort and display the array in alphabetical order.


my $i; my @revMonths;
my @months =("Jan", "Feb", "March","April","May","June","July","August","Sept","Oct","Nov","Dec");
print "the months of a year are:\n";
for ($i=0; $i<@months; $i++){
print "$months[$i]\n";
}

print "Total number of months in a year", scalar(@months),"\n", "index of the elements: ", $#months,"\n";
print "the 2nd,5th and 10th month are @months[1,4,9]\n"; 
print "The months in teh reverse order are:\n";
my @revMonths=reverse(@months);
for ($i=0; $i<@revMonths; $i++){
print "$revMonths[$i]\n";
}

push(@months,"New year");
print "The list of the months are:\n";
for ($i=0; $i<@months; $i++){
print "$months[$i]\n";
}

my @sortedMonths = sort(@months);
print "The sorted list of the months are:\n";
for ($i=0; $i<@sortedMonths; $i++){
print "$sortedMonths[$i]\n";
}


# Q2a:Create an array which contains the numbers 0 to 999.

# Q2b:
# Display ONLY the first number, the values from index 100 to 120, and the
# last number each separated by a space to the screen on a single line
# using a single print statement!

# Q2c:
# Remove the last element from the array.

# Q2d:
# Sort this array in ascending numerical order from 0 to 998.

#my @num = (0..999);
#print "@num[0, 100..120, 998]\n";
#system ("pause");

#pop(@num);
#print"@num\n";
#system("pause");

my @array =("a".."z");
my @returnArray = splice(@array,10);
print "@returnArray\n";
print "@array\n";


my @sat=@ARGV;
my $totSat=$#sat+1;
print "you have entered a $totSat word line that is: @sat\n";
print "the first three words are :@ARGV[0..2]\n";

system("pause");


