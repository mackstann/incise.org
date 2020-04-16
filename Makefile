build: out
	for i in pages/*.html; do ./template.py templates/base.html $$i > out/$$(basename $$i); done

out: static
	mkdir -p out
	rsync -a static/ out/

upload:
	rsync -vaP out/ nick@incise.org:/var/www/incise/

clean:
	rm -rf out

.PHONY: upload clean build
