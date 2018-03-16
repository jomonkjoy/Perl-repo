#!/usr/bin/perl -w

opendir(DIR, ".");
@files = grep(i/\.(v|vh|sv|vhdl|vhd)$/,readdir(DIR));
closedir(DIR);

foreach $file (@files) {
   print "$file\n";
}
