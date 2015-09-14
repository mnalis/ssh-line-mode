#!/usr/bin/perl -w
# demo: raw terminal using PTY; by Matija Nalis <mnalis-github@voyager.hr> GPLv3+, started 2015-09-14

use IO::Pty::Easy;
use Term::ReadKey;
use Time::HiRes qw(usleep);

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
        $input = '[E]' if $input eq "\ce";
        $input = '[S]' if $input eq "\c]";
        #print "[got input]";
        #print $input;
        my $chars = $pty->write($input, 0);
        last if defined($chars) && $chars == 0;
    } else {
        usleep(10000);		# 1/100 sec	-- FIXME: we should better use ReadKey(0.1) instead, but it does not seem to work ok.
    }
}

$pty->close;
ReadMode 'restore';
print "\n[Terminal exiting]\n";
