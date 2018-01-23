#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbUser = 'herculeze';
my $dbPW='';
my $database='herculezeTest';

my $dbh = DBI->connect("dbi:mysql:","$dbUser","$dbPW");
$dbh->do("use $database"); 

$dbh->do("drop table AD;");
$dbh->do("drop table Message;");
$dbh->do("drop table Photo;");
$dbh->do("drop table Job;");
$dbh->do("drop table User;");
