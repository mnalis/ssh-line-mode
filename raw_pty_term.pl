#!/usr/bin/perl -T
# demo: raw terminal using PTY; by Matija Nalis <mnalis-github@voyager.hr> GPLv3+, started 2015-09-14

use strict;
use warnings;
use IO::Pty::Easy;
use Term::ReadKey;

$ENV{'PATH'} = '/usr/local/bin:/usr/bin:/bin';
$|=1;

ReadMode 'ultra-raw';

my $pty = IO::Pty::Easy->new ( raw => 0 );
$pty->spawn("sh");

# define filedescriptors on which we will wait
my $r_in='';
vec($r_in, fileno(STDIN), 1) = 1;
vec($r_in, $pty->fileno, 1) = 1; 

while ($pty->is_active) {
    my $output = $pty->read(0);
    if (defined $output) {
         print $output;
         #print "[output ends]";
         last if defined($output) && $output eq '';
    }
    
    my $all_input = '';
    while (defined (my $input = ReadKey(-1))) {
        $input = '[E]' if $input eq "\ce";	# just few debug input sequences (ctrl-e, ctrl-]) for demo
        $input = '[S]' if $input eq "\c]";
        #print "[got input]";
        #print $input;
        $all_input .= $input;
    }
    if ($all_input ne '') {
        my $chars = $pty->write($all_input, 0);
        last if defined($chars) && $chars == 0;
    }
   
    select ($_=$r_in, undef, $_=$r_in, undef);	# infinite sleep until something comes on either on pty (output) or stdin (keyboard)
}

$pty->close;
ReadMode 'restore';
print "\n[Terminal exiting]\n";
