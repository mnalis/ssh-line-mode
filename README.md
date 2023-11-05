This is wrapper around ssh(1) which allows it to do local line editing
before sending it to remote host (also known by names such as telnet line mode,
line-by-line, line mode, line buffered mode, canonical mode, cooked mode,
RFC 1184)

It is inspired by line-by-line editing mode in telnet(1) of old.  

While most of the time you're much better served by char-by-char mode (which
is only mode openssh provides), line-by-line mode is much preferred when you
use SSH over high latency ("terrible ping") links (and/or high TCP packet loss
links) such as low wireless signal, overloaded (or flaky) GPRS EDGE mobile
networks and such - because you can do all the line editing locally without
involving network. Only when you press enter is whole line sent at once in
just one TCP packet (as opposed to dozens of them in char-by-char mode!)

There is MOSH package at https://mosh.org/ that is supposed to help with
those issues and more (like auto-reconnect), but it requires installing
additional programs on remote sides, fixing UTF-8 issues both on remote and
local sides, and configuring remote firewalls to pass additional traffic (it
also introduces new protocol, which should be as secure as SSH, but does not
have as many eyeballs over it).  And it provides predictive local echo only
instead of full local line editing.  You might want to look it over anyway.

But, if you just want to install one program on your laptop and do not touch
the servers at all, but still at times have some possibility of GNU readline 
(http://www.gnu.org/software/readline/) powered local line editing to battle 
the annoying network lag, this might just be a tool for you.

sshlm allows you to interactively choose whether to use line-by-line (with
local line editing) or common char-by-char mode.

See [USAGE.txt](USAGE.txt) for instructions.
