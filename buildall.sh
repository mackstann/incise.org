find pages -type f |
while read i
do
    (
        sh header.sh `basename "$i"`
        cat "$i" | perl -pe 's/^$/<p>/'
        cat footer.html
    ) > output/`basename "$i"`.html
done

