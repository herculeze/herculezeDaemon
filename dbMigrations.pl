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
  '-1', verificationCode varchar(32), bio varchar(1024), timesReported integer,
  phone varchar(15), addr1 varchar(100), addr2 varchar(100), city 
  varchar(30), state varchar(2), zip integer(5),paypal varchar(100) lat 
  varchar(15), lng varchar(15));");

$dbh->do("create table Job(jobID varchar(32) primary key, title varchar(50),
  weight integer, height integer, width integer, length integer, toAddr1
  varchar(100), toAddr2 varchar(100), toZip integer(5), toCity varchar(30),
  toState varchar(2), fromAddr1 varchar(100), fromAddr2 varchar(100), fromZip
  integer(5), fromCity varchar(30), fromState varchar(2), customerID
  varchar(32), completed integer(1) DEFAULT '0', description varchar(500),
  endTime integer, distance varchar(16), timeCreated integer, offer integer,
  distValue integer, lat varchar(15), lng varchar(15));");

$dbh->do("create table Photo(photoID varchar(32) primary key, fileName
  varchar(40), owner varchar(32));");

$dbh->do("create table Message(msgID varchar(32) primary key, toID varchar(32),
  fromID varchar(32), unread integer(1),subject varchar(64), messageTxt
  varchar(500), sent integer);");

$dbh->do("create table AD(email varchar(320), password varchar(64), token
  varchar(64), salt int);");

$dbh->do("create table Bid(bidID varchar(32) primary key, jobID varchar(32),
  driverID varchar(32), bidAmnt int, isWinningBid integer(1) DEFAULT '0');");

$dbh->do("create table Review(reviewID varchar(32) primary key, reviewerID
  varchar(32), revieweeID varchar(32), starRating int, reviewText varchar(1024), 
  date int, jobID varchar(32));");

$dbh->do("create table TruckPhoto(driverID varchar(32), photoID varchar(32), isProfilePic integer(1))");
$dbh->do("create table JobPhoto(jobID varchar(32), photoID varchar(32))");
$dbh->do("create table UserPhoto(userID varchar(32), photoID varchar(32), isProfilePic integer(1))");

my $time = time;
my $password = sha256_hex('Herculeze2323$'.$time);
$dbh->do("insert into AD(email,password,salt) values('customerservice\@herculeze.com',
  '$password', $time);");

$dbh->do("alter table Review add constraint fk_customerID_Rev foreign key
  (reviewerID) references User(userID);");

$dbh->do("alter table Review add constraint fk_driverID_Rev foreign key
  (revieweeID) references User(userID);");

$dbh->do("alter table Review add constraint fk_jobID_Rev foreign key
  (jobID) references Job(jobID);");

$dbh->do("alter table Job add constraint fk_customerID_Job foreign key
  (customerID) references User(userID);");

$dbh->do("alter table TruckPhoto add constraint fk_photoID_TruckPhoto foreign
  key (photoID) references Photo(photoID);");

$dbh->do("alter table TruckPhoto add constraint fk_driverID_TruckPhoto foreign
  key (driverID) references User(userID);");

$dbh->do("alter table JobPhoto add constraint fk_photoID_JobPhoto foreign
  key (photoID) references Photo(photoID);");

$dbh->do("alter table JobPhoto add constraint fk_jobID_JobPhoto foreign
  key (jobID) references Job(jobID);");

$dbh->do("alter table UserPhoto add constraint fk_userID_UserPhoto foreign
  key (userID) references User(userID);");

$dbh->do("alter table UserPhoto add constraint fk_photoID_UserPhoto foreign
  key (photoID) references Photo(photoID);");

$dbh->do("alter table Photo add constraint fk_owner foreign key (owner)
  references User(userID);");

$dbh->do("alter table Message add constraint fk_toID_Message foreign key (toID)
  references User(userID);");

$dbh->do("alter table Message add constraint fk_fromID_Message foreign key
  (fromID) references User(userID);");

$dbh->do("alter table Bid add constraint fk_driverID_Bid foreign key
  (driverID) references User(userID);");

$dbh->do("alter table Bid add constraint fk_jobID_Bid foreign key
  (jobID) references Job(jobID);");
