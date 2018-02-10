#!/usr/bin/perl

use warnings;
use strict;

##
# This file is to run on the web server as a daemon
#
# The daemon has the following responisibilities:
#   - Check for jobs with completed auctions and
#       - Update Job status
#       - Inform Customer
#       - Inform Driver


use DBI;

###############################################################################
my $dbUser = "herculeze";                                                        
my $dbPW = "";                                                                   
my $database = "herculezeTest";  

my $dbh = DBI->connect("dbi:mysql:","$dbUser","$dbPW");
$dbh->do("use $database;");   
###############################################################################

my @jobIDs = selectAllUnconditional("Job","jobID");
my $currentTime = time;

for my $id (@jobIDs)
{
  my($endTime, $customerID, $driverID, $completed, $currentBid) = 
    selectWhere("Job","endTime, customerID, driverID, completed, currentBid",
      "jobID", "$id and completed ! 0");

  my ($customerEmail, $customerFirstName, $customerLastName) = 
    selectWhere( "User", "email, fName, lName", "userID", $id);

  my ($driverEmail, $driverFirstName, $driverLastName) = 
    selectWhere( "User", "email, fName, lName", "userID", $id);

  if ($currentTime > $endTime)
  {
    $dbh->do(qq[ uodate Job set completed='1' where jobID='$id']);

    # email customer
    
    # email driver
  }
} 

sub selectAllUnconditional
{
	my $table = shift;
	my $col = shift;

	my $statement = "SELECT $col FROM $table;";
	my $preparedStatement  = $dbh->prepare($statement);
	$preparedStatement->execute();

	my @tmp;

	while (my @row = $preparedStatement->fetchrow_array())
	{
		push @tmp, $row[0];
	}
	return @tmp;
}

sub selectWhere                                                                  
{                                                                                
  my $table = shift;                                                             
  my $col = shift;                                                               
  my $var = shift;                                                               
  my $val = shift;                                                               
                                                                                 
  my $statement = "SELECT $col FROM $table where $var = \"$val\"";               
  $statement = $dbh->prepare($statement);                                        
  $statement->execute();                                                         
                                                                                 
  my @tmp = $statement->fetchrow_array();                                        
  return @tmp;                                                                
}
