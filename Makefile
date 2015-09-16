DSTDIR=/usr/local/bin

all:
	@echo 'use "make install" to install'
	
install:
	install -o root -g root -m 0755 sshlm ${DSTDIR}/sshlm

uninstall:
	rm -f ${DSTDIR}/sshlm
	
clean:
	rm -f *~
