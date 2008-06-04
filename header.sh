cat header.html
echo '<h1><a href="/">[incise.org]</a> '
echo "$1" | sed -e 's/-/ /g'
echo "</h1>"

