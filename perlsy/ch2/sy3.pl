#!user/bin/perl 
use utf8;
print "r:";
chomp($r = <STDIN>); # 接收输入变量并去掉换行符
if ($r < 0){
    print "c = 0\n"
} else{
    $c = 2*3.1415926535*$r;
    print "c = $c\n"
}
