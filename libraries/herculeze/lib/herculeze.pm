#!/usr/bin/perl
package herculeze;
use DBI;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(HTMLdisp selectWhere selectAllWhere);

my $dbUser = "herculeze";                                                        
my $dbPW = "";                                                                   
my $database = "herculezeTest";                                                  
my $dbh = DBI->connect("dbi:mysql:","$dbUser","$dbPW");                          
$dbh->do("use $database;");                     
sub HTMLdisp                                                                     
{                                                                                
  my $title = shift;                                                             
                                                                                 
  print "Content-type:text/html\n\n";                                            
  print "<html>";                                                                
  print "<head>";                                                                
  print "<title>$title</title>";                                                 
  print "<meta charset='utf-8'>";
  print "<LINK href='/projects/herculeze/app/style.css' rel='stylesheet' type='text/css'>";
  print "</head>";                                                               
  print "<body>";                                                                
                                                                                 
  foreach(@_)                                                                    
  {                                                                              
    print $_;                                                                    
  }                                                                              
                                                                                 
  print "</body>";                                                               
  print "</html>";                                                               
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

sub selectAllWhere
{
	my $table = shift;
	my $col = shift;
	my $var = shift;
	my $val = shift;

	my $statement = "SELECT $col FROM $table where $var = \"$val\"";
	my $preparedStatement  = $dbh->prepare($statement);
	$preparedStatement->execute();

	my @tmp;

	while (my @row = $preparedStatement->fetchrow_array())
	{
		push @tmp, $row[0];
	}
	return @tmp;
}
