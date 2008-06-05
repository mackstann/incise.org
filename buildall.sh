find pages -type f -name '*.html' |
while read i
do
    (
        sh header.sh `basename "$i" .html`
        cat "$i" | perl paragraphs.pl
        cat footer.html
    ) > output/`basename "$i"`
done

