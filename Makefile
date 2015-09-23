prefix = /usr/local
bindir = $(prefix)/bin
sharedir = $(prefix)/share
mandir = $(sharedir)/man
man1dir = $(mandir)/man1

all:
	@echo 'use "make install" to install, or "make deb" to build debian package'
	
install:
	test -d  ${DESTDIR}${bindir} || mkdir -p ${DESTDIR}${bindir}
	install sshlm ${DESTDIR}${bindir}/sshlm
	test -d  ${DESTDIR}${man1dir} || mkdir -p ${DESTDIR}${man1dir}
	install -m 0644 sshlm.1 $(DESTDIR)$(man1dir)/sshlm.1

uninstall:
	rm -f ${DESTDIR}${bindir}/sshlm $(DESTDIR)$(man1dir)/sshlm.1
	
clean:
	rm -f *~ *.bak

deb:
	debuild -uc -us

mrproper:
	./debian/rules clean
