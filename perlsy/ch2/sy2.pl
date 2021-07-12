#!user/bin/perl 
use utf8;
chomp($r = <STDIN>); # 接收输入变量并去掉换行符
$c = 2*3.1415926535*$r;
print "r = $r\nc = $c\n"