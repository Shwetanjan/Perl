use DBI;
use strict;
use warnings;

my ($inFile, $outFile, @fileData, $line, $i, @tempData,  %hashOfArrays);
$inFile  = "author.dat";

open(IN,  "< $inFile") || die("Error: Could not open INPUT file... '$inFile'  $!\n");

@fileData = <IN>;  # slurping entire raw file into individual array elements

close (IN);

$i = 0;
#/populate the has table/
foreach $line (@fileData) {
    
 @tempData = split ("#",$fileData[$i]);
 
 $hashOfArrays{$tempData[0]} = $tempData[1];
 $i++;
}

foreach my $key ( keys %hashOfArrays)
{
  print "key: $key, value: $hashOfArrays{$key}\n";
}
#print %hashOfArrays,"\n";

my ($driver, $dataBase, $dataBaseConnect, $userid, $passwd, $dbh);
my ($sqlStatement, $sth, $rv, @row, $tableName);

$driver   = "mysql";
$dataBase = "wisdom";
$dataBaseConnect = "DBI:$driver:dbname=$dataBase";
$userid = "root";
$passwd = "S\@ttvik";

$tableName = "quotes";
$dbh = DBI->connect($dataBaseConnect, $userid, $passwd, { RaiseError => 1 })
	    or die $DBI::errstr;
print "Successfully Opened database...\n";

$dbh->do("DROP TABLE IF EXISTS $tableName");

$sqlStatement = qq(CREATE TABLE $tableName
(id     INT PRIMARY KEY  NOT NULL,
author VARCHAR(100) NOT NULL,
quote  VARCHAR(500) NOT NULL)
);
#$sqlStatement= qq(CREATE TABLE $tableName
#		  ( ID INT PRIMARY KEY      NOT NULL,
#		    author VARCHAR(100)   NOT NULL,
#		    LOCUS      VARCHAR(100) NOT NULL,
#		    DEF        VARCHAR(100) NOT NULL,
#			 ACC        CHAR(10)     NOT NULL,
#			 ORIGIN      TEXT        NOT NULL);
#		  );

$rv = $dbh->do($sqlStatement);
if($rv < 0) {
   print $DBI::errstr;
}
else {
   print "Successfully Created Table...\n";
}

my $num = scalar(keys(%hashOfArrays));
my @author = keys(%hashOfArrays);
#/my @quotes = values(%hashofArrays);/
my $key;
$i=0;
foreach $key(@author){

$sqlStatement = qq(INSERT INTO quotes (id, author, quote)
		   VALUES ($i+1, '$author[$i]', '$hashOfArrays{$author[$i]}');
		);
		
	$i++;	#$sqlStatement = qq(INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
		#   VALUES (213, 'Larry Wall', 68, 'California', 50000.00)
		#);
$rv = $dbh->do($sqlStatement) or die $DBI::errstr;

}



$dbh->disconnect( );

