find pages -type f |
while read i
do
    (
        sh header.sh `basename "$i"`
        cat "$i"
        cat footer.html
    ) > output/`basename "$i"`.html
done

