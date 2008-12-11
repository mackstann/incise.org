all: clean build
install: all upload

build:
	./buildall.py

clean:
	rm -rf output

upload:
	rsync -vza --checksum -e ssh output/ nwelch@biggs.dreamhost.com:incise.org/ & \
	rsync -vza --checksum -e ssh restofsite/ nwelch@biggs.dreamhost.com:incise.org/ & \
	wait

checkstale:
	./stale_pages.py
