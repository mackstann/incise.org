all: clean build
install: all upload

build:
	./buildall.py
	cp -p redir.cgi.pl output/index.cgi
	chmod +x output/index.cgi

clean:
	rm -rf output

upload:
	rsync -vza --checksum -e ssh output/ nwelch@biggs.dreamhost.com:incise.org/
	rsync -vza --checksum -e ssh restofsite/ nwelch@biggs.dreamhost.com:incise.org/
	./stale_pages.py

