build:
	mkdir -p out
	rsync --delete -ca static/ out/
	for i in pages/*.html; do ./template.py templates/base.html $$i > out/$$(basename $$i); done

upload:
	rsync --delete -cvaz out/ nick@incise.org:/var/www/incise/

clean:
	rm -rf out

.PHONY: upload clean build
