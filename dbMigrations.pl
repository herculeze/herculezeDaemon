#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use Digest::SHA qw/sha256_hex/;

my $dbUser = $ENV{"DBUSER"};
my $dbPW = $ENV{"DBPASS"};
my $database = $ENV{"DATABASE"};

my $dbh = DBI->connect("dbi:mysql:","$dbUser","$dbPW");
$dbh->do("use $database"); 

$dbh->do("create table User(userID varchar(32) primary key, salt int, fName
  varchar(20), lName varchar(20), email varchar(320), password varchar(64),
  accType integer(1), authToken varchar(32), accountStatus integer(1) DEFAULT
  '-1', verificationCode varchar(32));");

$dbh->do("create table Job(jobID varchar(32) primary key, title varchar(50),
  weight integer, height integer, width integer, length integer, toAddr1
  varchar(100), toAddr2 varchar(100), toZip integer(5), toCity varchar(30),
  toState varchar(2), fromAddr1 varchar(100), fromAddr2 varchar(100), fromZip
  integer(5), fromCity varchar(30), fromState varchar(2), customerID
  varchar(32), driverID varchar(32), completed integer(1) DEFAULT '0',
  description varchar(500), winningBidID varchar(32), endTime integer, distance
  varchar(16), timeCreated integer);");

$dbh->do("create table Photo(jobID varchar(32), fileName varchar(40), driverID
  varchar(32));");

$dbh->do("create table Message(msgID varchar(32) primary key, toID varchar(32),
  fromID varchar(32), unread integer(1),subject varchar(64), messageTxt
  varchar(500), sent integer);");

$dbh->do("create table AD(email varchar(320), password varchar(64), token
  varchar(64), salt int);");

$dbh->do("create table Bid(bidID varchar(32), jobID varchar(32), driverID
  varchar(32), bidAmnt int);");

my $password = sha256_hex("admin12345");
$dbh->do("insert into AD(email,password,salt) values('admin\@example.com',
  '$password', '12345');");

$dbh->do("alter table Job add constraint fk_customerID foreign key
  (customerID) references User(userID);");

$dbh->do("alter table Job add constraint fk_driverID foreign key (driverID)
  references User(userID);");

$dbh->do("alter table Job add constraint fk_winningBidID foreign key
  (winningBidID) references Bid(bidID);");

$dbh->do("alter table Photo add constraint fk_jobID foreign key (jobID)
  references Job(jobID);");

$dbh->do("alter table Photo add constraint fk_driverID foreign key (driverID)
  references User(userID);");

$dbh->do("alter table Message add constraint fk_toID foreign key (toID)
  references User(userID);");

$dbh->do("alter table Message add constraint fk_fromID foreign key (fromID)
  references User(userID);");

$dbh->do("alter table Bid add constraint fk_driverID foreign key
  (driverID) references User(userID);");

$dbh->do("alter table Bid add constraint fk_jobID foreign key
  (jobID) references Job(jobID);");
