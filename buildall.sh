python -c 'import pygments.formatters; \
           print pygments.formatters.HtmlFormatter(classprefix="pyg-").get_style_defs()' \
    > output/pygments.css

find pages -type f -name '*.html' |
while read i
do
    ctime=`git log --date=short "$i" | grep ^Date: | tail -n1 | awk '{print $2}'`
    mtime=`git log --date=short "$i" | grep ^Date: | head -n1 | awk '{print $2}'`
    test "$ctime" = 2008-06-05 && ctime="long ago.."
    test "$mtime" = 2008-06-05 && mtime="long ago.."

    dir=`dirname "$i"`
    base=`basename "$i" .html`
    titlefile="$dir"/"$base".title
    if [ -f "$titlefile" ]
    then
        title=`cat "$titlefile"`
    else
        title=`echo "$base" | sed -e 's/-/ /g'`
    fi
    outdir=`echo "$dir" | sed -e 's,^pages,output,'`
    mkdir -p "$outdir"
    (
        sh header.sh "$title" "$ctime" "$mtime"
        cat "$i"
        sh footer.sh "$title" "$ctime" "$mtime"
    ) | python paragraphs.py | python highlight.py > "$outdir"/`basename "$i"`
done

