#!/usr/bin/perl

# A program to parse a Google AdSense CSV file, and convert it to
# a better format, with all of the undesirable lines removed
#
# Usage: ./parse.pl GoogleCsvFile.csv > BetterGoogleCsvFile.csv

$numArgs = $#ARGV + 1;
die if ($numArgs != 1);

$file = $ARGV[$argnum];
open (F, $file) || die ("Could not open $file!");

$do_skip_test = 1;
while ($line = <F>) {
    if ($do_skip_test) {
        if ($line =~ /^Page/) {
            # got to the starting point, don't skip lines any more
            $do_skip_test = 0;
        }
        else {
            next;
        }
    }

    # skip these lines, i don't want/need them
    next if $line =~ /^#/;
    next if $line =~ /search/;
    next if $line =~ /\/node/;
    next if $line =~ /jwarehouse/;

    ($uri, $rev, $clicked, $imps, $ctr, $ecpm) = split ',', $line;
    chomp($ecpm);
    next if ($clicked < 2);
    next if ($imps < 50);

    print "$uri, $rev, $clicked, $imps, $ctr, $ecpm\n";
}

close (F);
