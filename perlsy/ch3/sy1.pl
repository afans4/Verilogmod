#!user/bin/perl
use utf8;
print "Please input string,then input Ctrl + Z of end\n";
@strin = <STDIN>;
@restr = reverse(@strin);
print "string reverse:\n";
print "@restr";