#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;
use CGI qw/header/;
use JSON qw/decode_json/;
use Data::Dumper;

my $res = get("https://marketplace.herculeze.com/cgi-bin/referer.cgi?secret=1d1573b9acbd3a6bb370955144e24db64df1019ef7d5375103566c820446cfc4");

my $decodedJSON = decode_json($res);

my @arr = @{$decodedJSON->{data}};

print header;
print qq[
<html>
<head>
  <LINK href='/style.css' rel='stylesheet' type='text/css'>
</head>
<body>
<table>
  <tr>
    <th>Email</th>
    <th>Refered By</th>
    <th>Job Completed</th>
    <th>Reward Dispensed</th>
    <th></th>
  </tr>
];

print qq[
<tr>
  <td>$_->{email}</td>
  <td>]. ($_->{referer}//"").qq[
  <td>]. ($_->{jobComplete}?"x"x18:"").qq[
  <td>]. ($_->{rewardReceived}?"x"x18:"").qq[
  <td> <a href="/ref/bin?id=]. ($_->{ID}//""). qq[">Reward Dispensed</a></td>
</tr>
] for @arr;

print q[</table></body></html>];
