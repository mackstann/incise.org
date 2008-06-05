pagemod=`ls -l pages/"$1".html | awk '{print $6, $7}'`
sitemod=`ls -ld pages | awk '{print $6, $7}'`
echo "
<hr>
<address>
Nick Welch <a href=\"mailto:nick@incise.org\">&lt;nick@incise.org&gt;</a><br>
This page last modified on $pagemod.<br>
incise.org last modified on $sitemod.
</address>
</body>
</html>
"

