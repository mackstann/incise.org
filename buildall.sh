find pages -type f -name '*.html' |
while read i
do
    (
        base=`basename "$i" .html`
        if [ -f pages/"$base".title ]
        then
            title=`cat pages/"$base".title`
        else
            title=`echo "$base" | sed -e 's/-/ /g'`
        fi
        sh header.sh "$title"
        cat "$i" | perl paragraphs.pl
        sh footer.sh "$title"
    ) > output/`basename "$i"`
done

