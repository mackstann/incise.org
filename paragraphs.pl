use strict;
use warnings;

my $in_pre = 0;

while (<STDIN>) {
    $in_pre = 1 if $_ =~ m#<pre>#i;
    $in_pre = 0 if $_ =~ m#</pre>#i;

    if($_ =~ /^[ \t]*$/ && !$in_pre) {
        print "<p>\n";
    } else {
        print;
    }
}

