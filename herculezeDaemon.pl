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
