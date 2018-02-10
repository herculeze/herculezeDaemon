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
