#!/usr/bin/perl -w

#
# wm-menu.pl
#
# creates a menu of your installed dockapps, and lets you toggle them on/off
#
# author: mackstann <mack at incise.org>
# 
# date: Fri Dec  6 02:12:52 CST 2002
#
# notes: if you use special arguments for your dockapps, and want them to
# be used when they are launched from this menu, set some aliases in your
# shell.  i.e. for bash, in ~/.bashrc have a line like this:
#
#   alias wmsomething='wmsomething --with some --options 123'
#   

if(`uname -s` !~ /linux/i) {
  die '[title] (you\'re not on linux!  you\'ll have to hack this script to make it work.  sorry!)';
}

# dockapp not here?  go ahead and add it, and let me know the name!
@dockapps = ('wmapm','wmavgload','wmbattery','wmbiff','wmbio','wmbubble',
'wmbutton','wmcalc','wmcalclock','wmcb','wmcdplay','wmclock','wmcoincoin',
'wmcpu','wmcpuload','wmcube','wmdate','wmfire','wmfsm','wmget','wmgrabimage',
'wmgtemp','wmifinfo','wmifs','wminet','wmitime','wmix','wmload','wmlongrun',
'wmmail','wmmand','wmmatrix','wmmemload','wmmemmon','wmmixer','wmmon',
'wmmoonclock','wmmount','wmnd','wmnet','wmnetmon','wmnetscapekiller',
'wmnetselect','wmnut','wmpinboard','wmpload','wmppp.app','wmppxp','wmpuzzle',
'wmrack','wmressel','wmscope','wmsensors','wmshutdown','wmsmpmon',
'wmspaceweather','wmsun','wmsysmon','wmtictactoe','wmtime','wmtimer','wmtop',
'wmtv','wmtz','wmusic','wmwave','wmweather','wmwork','wmx10','wmxmms-spectrum',
'wmxres','wmsetimon','wmufo','wampager','wmnetload');

@path = ('/usr/bin', '/usr/local/bin');

print "[title] (dockapps)\n";

foreach $value (@dockapps) {
  foreach $thispath (@path) {
    if( -x "$thispath/$value") { #if its executeable
      my $pid = `pidof $value`;
      chomp $pid;
      if($pid eq "") {
        print "[item] ($value - toggle on) {$value}\n";
      } else {
        print "[item] ($value - toggle off) {killall -9 $value}\n";
      }
    }
  }
}

