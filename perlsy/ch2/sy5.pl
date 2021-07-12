#!user/bin/perl 
use utf8;
print "please input str:";
$str = <STDIN>;
print "please input num:";
chomp($num = <STDIN>);
$outs = $str x $num;
print "$outs";