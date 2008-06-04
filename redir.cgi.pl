#!/usr/bin/perl

my %map = (
    '/index.cgi/AdvancedSimCityStrategies/Cookie'           => '/advanced-sim-city-strategies-cookie.html',
    '/index.cgi/AdvancedSimCityStrategies'                  => '/advanced-sim-city-strategies.html',
    '/index.cgi/BmxGearRatios'                              => '/bmx-gear-ratios.html',
    '/index.cgi/DisgaeaCheatSheet'                          => '/disgaea-cheat-sheet.html',
    '/index.cgi/FinalFantasy6Hacking'                       => '/final-fantasy-6-hacking.html',
    '/index.cgi/FlashMakingFirefoxRaiseItself'              => '/flash-making-firefox-raise-itself.html',
    '/index.cgi/Flypper'                                    => '/flypper.html',
    '/index.cgi/FrontPage'                                  => '/',
    '/index.cgi/'                                           => '/',
    '/index.cgi'                                            => '/',
    '/index.cgi/GettingStartedSellingSharewareGames/MyPlan' => '/getting-started-selling-shareware-games-my-plan.html',
    '/index.cgi/GettingStartedSellingSharewareGames'        => '/getting-started-selling-shareware-games.html',
    '/index.cgi/GnomeVfsCommandLineTools'                   => '/gnome-vfs-command-line-tools.html',
    '/index.cgi/GoodQuotes'                                 => '/good-quotes.html',
    '/index.cgi/GreenHomeScratchPage'                       => '/green-home-scratch-page.html',
    '/index.cgi/INTP_links'                                 => '/intp-links.html',
    '/index.cgi/LinuxFormatKahakaiArticle'                  => '/linux-format-kahakai-article.html',
    '/index.cgi/MaybeOurEntireWayOfLifeIsASham'             => '/maybe-our-entire-way-of-life-is-a-sham.html',
    '/index.cgi/MegaProgrammingLanguage'                    => '/mega-programming-language.html',
    '/index.cgi/NotSoTinyWindowManagers'                    => '/not-so-tiny-window-managers.html',
    '/index.cgi/OldAssStuff'                                => '/old-ass-stuff.html',
    '/index.cgi/OldWaimeaPage'                              => '/old-waimea-page.html',
    '/index.cgi/PerfectKeyboard'                            => '/perfect-keyboard.html',
    '/index.cgi/PostgresArrayStuff'                         => '/postgres-array-stuff.html',
    '/index.cgi/PygamePatchThoughts'                        => '/pygame-patch-thoughts.html',
    '/index.cgi/py-libmpdclient2'                           => '/py-libmpdclient2.html',
    '/index.cgi/Pymp'                                       => '/pymp.html',
    '/index.cgi/SimpleUnixSharedMemoryInterface'            => '/simple-unix-shared-memory-interface.html',
    '/index.cgi/SpookWindowManager'                         => '/spook-window-manager.html',
    '/index.cgi/Statiki'                                    => '/statiki.html',
    '/index.cgi/ThoughtsWhileLearningErlang'                => '/thoughts-while-learning-erlang.html',
    '/index.cgi/Thump'                                      => '/thump.html',
    '/index.cgi/TinyWM'                                     => '/tinywm.html',
    '/index.cgi/TypeMatrixReview'                           => '/typematrix-review.html',
    '/index.cgi/UnBustYourXserver'                          => '/un-bust-your-x-server.html',
    '/index.cgi/UsbHardDriveInLunix'                        => '/usb-hard-drive-in-lunix.html',
    '/index.cgi/VerySimpleGoogleMapsHack'                   => '/very-simple-google-maps-hack.html',
    '/index.cgi/ViewportsAndVirtualDesktops'                => '/viewports-and-virtual-desktops.html',
    '/index.cgi/VimTips'                                    => '/vim-tips.html',
    '/index.cgi/WebPyNotes'                                 => '/web.py-notes.html',
    '/index.cgi/WhatToEatWhenGoingBackToIowa'               => '/what-to-eat-when-going-back-to-iowa.html',
    '/index.cgi/Whimsy/Ideas'                               => '/whimsy-ideas.html',
    '/index.cgi/Whimsy/Status'                              => '/whimsy-status.html',
    '/index.cgi/Whimsy/ToDo'                                => '/whimsy-todo.html',
    '/index.cgi/Whimsy'                                     => '/whimsy.html',
    '/index.cgi/WhyViewportsRule'                           => '/why-viewports-rule.html',
    '/index.cgi/XlibKeyPassing'                             => '/xlib-key-passing.html',
);

sub print_page
{
    my ($http_status, $message, $newurl) = @_;
    print "Content-type: text/html\r\n";
    print "Status: $http_status\r\n";
    print "Location: $newurl\r\n" if $newurl;
    print "\r\n";
    print "<html><head><title>$http_status</title></head>";
    print "<body><h1>$http_status</h1><p>$message</p></body></html>";
}

my $newpath = $map{$ENV{REQUEST_URI}};

if($newpath) {
    my $newurl = "http://incise.org$newpath\r\n\r\n";
    print_page('301 Moved Permanently', qq|
        This page has been permanently moved.  The new location is at <a
        href="$newurl">$newurl</a>.  Please update your links and bookmarks.
    |, $newurl);
} else {
    print_page('404 Not Found', qq|
        It appears that you are looking for an old wiki page that has been
        permanently removed.  The MoinMoin wiki installation at this site has
        been removed and any old wiki pages that did not pertain to the core
        content of the site are permanently gone.  You can visit the new main
        page of incise.org at <a href="http://incise.org">http://incise.org</a>.
        Please update your links and bookmarks.
    |);
}

