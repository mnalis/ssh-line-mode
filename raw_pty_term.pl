#!/usr/bin/perl -w
# demo: raw terminal using PTY; by Matija Nalis <mnalis-github@voyager.hr> GPLv3+, started 2015-09-14

use IO::Pty::Easy;
use Term::ReadKey;

ReadMode 'ultra-raw';

my $pty = IO::Pty::Easy->new ( raw => 0 );
$pty->spawn("sh");

while ($pty->is_active) {
    my $output = $pty->read(0);
    if (defined $output) {
         print $output;
         #print "[output ends]";
         last if defined($output) && $output eq '';
    }
    
    my $input = ReadKey(-1);
    if (defined $input) {
        #print "[got input]";
        #print $input;
        my $chars = $pty->write($input, 0);
        last if defined($chars) && $chars == 0;
    }
}

$pty->close;
ReadMode 'restore';

