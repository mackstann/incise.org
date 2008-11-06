use strict;
use warnings;

my @newnames = qw/
very-simple-google-maps-hack
un-bust-your-x-server
typematrix-review
thump
statiki
spook-window-manager
pymp
perfect-keyboard
old-waimea-page
old-ass-stuff
not-so-tiny-window-managers
linux-format-kahakai-article
intp-links
good-quotes
xlib-key-passing
why-viewports-rule
whimsy-todo
whimsy-status
whimsy-ideas
whimsy
what-to-eat-when-going-back-to-iowa
web-py-notes
vim-tips
viewports-and-virtual-desktops
usb-hard-drive-in-lunix
tinywm
thoughts-while-learning-erlang
simple-unix-shared-memory-interface
py-libmpdclient2
pygame-patch-thoughts
postgres-array-stuff
mega-programming-language
maybe-our-entire-way-of-life-is-a-sham
green-home-scratch-page
gnome-vfs-command-line-tools
getting-started-selling-shareware-games-myplan
getting-started-selling-shareware-games
flypper
flash-making-firefox-raise-itself
final-fantasy-6-hacking
frontpage
advanced-sim-city-strategies
bmx-gear-ratios
advanced-sim-city-strategies-cookie
disgaea-cheat-sheet
/;

my %renames = map {
    my $oldname = ucfirst $_;
    foreach my $letter ('a' .. 'z') {
        my $u = uc $letter;
        $oldname =~ s/\-$letter/$u/g;
    }
    $oldname => $_;
} @newnames;

# page names that didn't get caught by my crude logic -- hard code them
$renames{'TinyWM'} = 'tinywm';
$renames{'AdvancedSimCityStrategies(2f)Cookie'} = 'advanced-sim-city-strategies-cookie';
$renames{'GettingStartedSellingSharewareGames(2f)MyPlan'} = 'getting-started-selling-shareware-games-my-plan';
$renames{'UnBustYourXserver'} = 'un-bust-your-x-server';
$renames{'TypeMatrixReview'} = 'typematrix-review';
$renames{'FinalFantasy6Hacking'} = 'final-fantasy-6-hacking';
$renames{'INTP links'} = 'intp-links';
$renames{'py-libmpdclient2'} = 'py-libmpdclient2';

system('clear');

while (<STDIN>) {

    s#\r##g;
    s#^====== #<h6>#g;
    s#^===== #<h5>#g;
    s#^==== #<h4>#g;
    s#^=== #<h3>#g;
    s#^== #<h2>#g;
    s#^= #<h1>#g;

    s# ====== *$#</h6>#g;
    s# ===== *$#</h5>#g;
    s# ==== *$#</h4>#g;
    s# === *$#</h3>#g;
    s# == *$#</h2>#g;
    s# = *$#</h1>#g;

    foreach my $oldname (keys %renames) {
        my $newname = $renames{$oldname};
        my $text = $newname;
        $text =~ s/-/ /g;
        s#$oldname#<a href="$newname.html">$text</a>#g;
    }
    s#\[([^ "]+) ([^\]]+)\]#<a href="$1">$2</a>#g;

    s{\|\|$}{</td></tr>}g;
    s{^\|\|}{<tr><td>}g;
    s{\|\|}{</td><td>}g;
    s{<td><style}{<td style}g;

    s{^( +)\* (.+)$}{$1<li>$2</li>}g;

    s#http://incise.org(/[^ ]+\.)(png|gif|jpeg|jpg)#<img src="$1$2">#g;

    #s#\["([^"]+)"\]#<a href="$1.html">$1</a>#g;
    s#\["##g;
    s#"\]##g;

    s/^{{{(#!.*)?$/<pre>/;
    s#^}}}$#</pre>#;

    s#{{{(.+?)}}}#<code>$1</code>#g;
    s#'''(.+?)'''#<strong>$1</strong>#g;
    s#''(.+?)''#<em>$1</em>#g;
    s#'''(.+?)'''#<strong>$1</strong>#g;
    s#''(.+?)''#<em>$1</em>#g;
    s#'''(.+?)'''#<strong>$1</strong>#g;
    s#''(.+?)''#<em>$1</em>#g;

    s/^##.*//g;

    print;
}

