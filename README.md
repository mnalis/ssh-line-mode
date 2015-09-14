=== This is work in progress and not functinal yet as of 2015-09-14 !!! ===

This is wrapper around ssh(1) which allows it to do local line editing
before sending it to remote host (also known by names such as telnet line mode,
line-by-line, line mode, line buffered mode, canonical mode, cooked mode,
RFC 1184)

It is inspired by line-by-line editing mode in telnet(1) of old.  

While most of the time you're much better served by char-by-char mode (which
is only mode openssh provides), line-by-line mode is much preferred when you
use SSH over high latency ("terrible ping") links (and/or high TCP packet loss
links) such as low wireless signal, overloaded (or flakey) GPRS EDGE mobile
networks and such - because you can do all the line editing locally without
involving network. Only when you press enter is whole line sent at once in
just one TCP packet.

There is MOSH package at https://mosh.mit.edu/ that is supposed to address
those issues and more, but it requires installing additional programs on
remote sides, fixing UTF-8 issues both on remote and local sides, and
configuring remote firewalls to pass additional traffic (it also introduces
new protocol, which should be as secure as SSH, but does not have as many
eyeballs over it). Look it over.

But, if you just want to install one program on your laptop and do not touch
the servers at all, but still at times have some posibility of local
readline line editing to battle the annoying network lag, this might just
help you.

(or, it MIGHT help you once it is finished, which CURRENTLY IT IS NOT)