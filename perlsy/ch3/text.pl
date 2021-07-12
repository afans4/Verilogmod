#!user/bin/perl
use utf8;
@rocks = qw(talc quartz jade obsidian);
print "How many rocks do you have?\n";
print "I have ",@rocks," rocks!\n";
print "I have ",scalar @rocks," rocks!\n";