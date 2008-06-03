all: clean
	mkdir -p output
	sh buildall.sh

clean:
	rm -rf output

install: all
	rsync -vza --delete -P -e ssh output/ nwelch@bsd3.quadrahosting.com:incise.org/newsite/
