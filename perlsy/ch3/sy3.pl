#!user/bin/perl
use utf8;
print "Please input string,then input Ctrl + Z of end\n";
@strin = sort <STDIN>;
print "@strin";
chomp(@strin);
print "@strin";