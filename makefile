.DEFAULT_GOAL := all
.PHONY: all clean install uninstall tncattach

compiler = gcc
flags = -Wall -std=gnu11 -static-libgcc

all: tncattach
rebuild: clean all

clean:
	@echo "Cleaning tncattach build..."
	@rm -f tncattach

tncattach:
	@echo "Making tncattach..."
	@echo "Compiling with: ${compiler}"
	${compiler} ${flags} tncattach.c Serial.c TCP.c KISS.c TAP.c -o tncattach -Wall

install:
	@echo "Installing tncattach..."
	@chmod a+x tncattach
	cp ./tncattach /usr/local/sbin/
	@echo "Installing man page..."
	@mkdir -p /usr/local/man/man8
	@install -m 644 -o root -g root tncattach.8 /usr/local/man/man8/tncattach.8
	@echo "Updating mandb..."
	@mandb -f /usr/local/man/man8/tncattach.8 2> /dev/null 1> /dev/null
	@echo "Done"

uninstall:
	@echo "Uninstalling tncattach"
	rm /usr/local/sbin/tncattach
	rm /usr/local/man/man8/tncattach.8
