pagemod=`ls -l pages/"$1".html | awk '{print $6}'`
sitemod=`ls -ld pages | awk '{print $6}'`
<hr>
Nick Welch <a href="mailto:mack@incise.org">&lt;mack@incise.org&gt;</a><br>
This page last modified on $pagemod.<br>
Site last updated on $sitemod.<br>
</body>
</html>

