#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;
use CGI qw/header url_param redirect/;
use Data::Dumper;

my $id;

if ($id = url_param('id'))
{
  my $res = get("https://marketplace.herculeze.com/cgi-bin/rewardDispensed.cgi?secret=1d1573b9acbd3a6bb370955144e24db64df1019ef7d5375103566c820446cfc4&id=$id");
}

print redirect('/ref');
