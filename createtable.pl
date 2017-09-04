#!/usr/bin/perl
use DBI;
use strict;
use warnings;
use DBD::mysql;

my ($driver, $dataBase, $dataBaseConnect, $userid, $passwd, $dbh);
my ($sqlStatement, $sth, $rv, @row, $tableName);
$driver   = "mysql";
$dataBase = "bacteria";
$dataBaseConnect = "DBI:$driver:dbname=$dataBase";
$userid = "root";
$passwd = "S\@ttvik"; 
$tableName = "cre";
$dbh = DBI->connect($dataBaseConnect, $userid, $passwd, { RaiseError => 1 })
	    or die $DBI::errstr;
print "Successfully Opened database...\n";

$dbh->do("DROP TABLE IF EXISTS $tableName");

$sqlStatement = qq(CREATE TABLE $tableName
		  ( ID INT PRIMARY KEY      NOT NULL,
		    URL        CHAR(50)     NOT NULL,
		    LOCUS      VARCHAR(100) NOT NULL,
		    DEF        VARCHAR(100) NOT NULL,
			 ACC        CHAR(10)     NOT NULL,
			 ORIGIN      TEXT        NOT NULL);
		  );
$rv = $dbh->do($sqlStatement);
if($rv < 0) {
   print $DBI::errstr;
}
else {
   print "Successfully Created Table...\n";
}
$dbh->disconnect( )