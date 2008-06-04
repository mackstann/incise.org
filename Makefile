all: clean
	mkdir -p output
	sh buildall.sh
	cp redir.cgi.pl output/index.cgi
	chmod +x output/index.cgi

clean:
	rm -rf output

install: all
	rsync -vza -e ssh output/ nwelch@bsd3.quadrahosting.com:incise.org/

