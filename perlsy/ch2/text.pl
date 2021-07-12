#!/user/bin/perl
use utf8;
$line = <STDIN>;
if ($line eq "\n"){
    print "That was just a blank line!\n";
} else {
    print "That line of input was: $line";
}