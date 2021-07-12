#!user/bin/perl
use utf8;
print "Please input some number,then input Ctrl + Z of end\n";
chomp(@num = <STDIN>);
@name = qw(fred betty dino wilma pebbles bamm-bamm);
foreach $num (@num) {
    print "@name[$num-1]\n";
}
