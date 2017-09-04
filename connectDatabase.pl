#!/usr/bin/perl


#use lib "/home/shweta/perl5/lib/perl5/x86_64-linux/Bundle/";
use DBI;
use strict;


use warnings;
use DBD::mysql;



my ($driver, $dataBase, $dataBaseConnect, $userid, $passwd, $dbh);

$driver   = "mysql";
$dataBase = "bacteria";
$dataBaseConnect = "DBI:mysql:dbname=$dataBase";
$userid = "root";
$passwd = "S\@ttvik";
$dbh = DBI->connect($dataBaseConnect, $userid, $passwd, { RaiseError => 1 })
	    or die $DBI::errstr;
print "Successfully Opened database...\n";