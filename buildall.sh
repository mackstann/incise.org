find pages -type f -name '*.html' |
while read i
do
    (
        sh header.sh `basename "$i" .html`
        cat "$i" | perl paragraphs.pl
        sh footer.sh `basename "$i" .html`
    ) > output/`basename "$i"`
done

