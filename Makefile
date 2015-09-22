DESTDIR=/usr/local
BINDIR=${DESTDIR}/bin

all:
	@echo 'use "make install" to install, or "make deb" to build debian package'
	
install:
	test -d ${BINDIR} || mkdir -p ${BINDIR}
	install -o root -g root -m 0755 sshlm ${BINDIR}/sshlm

uninstall:
	rm -f ${BINDIR}/sshlm
	
clean:
	rm -f *~

deb:
	dpkg-buildpackage -rfakeroot -uc -us

mrproper:
	./debian/rules clean
