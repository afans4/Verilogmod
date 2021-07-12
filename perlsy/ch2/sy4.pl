#!user/bin/perl 
use utf8;
print "a:";
chomp($a = <STDIN>);
print "b:";
chomp($b = <STDIN>);
$mux = $a * $b;
print "a*b = $mux";