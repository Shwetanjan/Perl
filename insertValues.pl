use DBI;
use strict;
use warnings;

my ($driver, $dataBase, $dataBaseConnect, $userid, $passwd, $dbh);
my ($sqlStatement, $sth, $rv, @row);

$driver   = "SQLite";
$dataBase = "test.db";
$dataBaseConnect = "DBI:$driver:dbname=$dataBase";
$userid = "";
$passwd = "";
$dbh = DBI->connect($dataBaseConnect, $userid, $passwd, { RaiseError => 1 })
	    or die $DBI::errstr;
print "Successfully Opened database...\n";

$sqlStatement = qq(INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
		   VALUES (214, 'Tim Cook', 62, 'San Francisco', 189000000.00)
		);
$rv = $dbh->do($sqlStatement) or die $DBI::errstr;

$sqlStatement = qq(INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
		   VALUES (213, 'Larry Wall', 68, 'California', 50000.00)
		);
$rv = $dbh->do($sqlStatement) or die $DBI::errstr;

$sqlStatement = qq(INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
		   VALUES (416, 'Danny Abesdris', 21, 'Toronto', 19.99)
		);
$rv = $dbh->do($sqlStatement) or die $DBI::errstr;

$sqlStatement = qq(INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
		   VALUES (613, 'Justin Trudeau', 45, 'Ottawa', 232000.00)
		);
$rv = $dbh->do($sqlStatement) or die $DBI::errstr;

print "Records created successfully\n";
$dbh->disconnect( );