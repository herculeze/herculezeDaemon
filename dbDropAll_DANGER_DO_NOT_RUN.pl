#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbUser = $ENV{"DBUSER"};
my $dbPW = $ENV{"DBPASS"};
my $database = $ENV{"DATABASE"};

my $dbh = DBI->connect("dbi:mysql:","$dbUser","$dbPW");
$dbh->do("use $database"); 

$dbh->do("drop table Bid;");
$dbh->do("drop table AD;");
$dbh->do("drop table TruckPhoto;");
$dbh->do("drop table JobPhoto;");
$dbh->do("drop table UserPhoto;");
$dbh->do("drop table Message;");
$dbh->do("drop table Review;");
$dbh->do("drop table Job;");
$dbh->do("drop table Photo;");
$dbh->do("drop table User;");
