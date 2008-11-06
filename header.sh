title="$1"
ctime="$2"
mtime="$3"
if [ "$ctime" = "long ago.." ]
then
    titledate=''
else
    titledate="$ctime"
fi
echo "
<html>
<head>
<title>incise.org - $title</title>
<link rel="stylesheet" type="text/css" href="/pygments.css" /> 
<style type="text/css">
    body { font-family: sans-serif; }
    table, tr { background: #aaa; }
    td, th { background: white; }
    address { font-size: small; }
    .titledate { font-size: small; color: #555; vertical-align: super; }
    pre { background: #ffe; border: 1px solid #666; padding: 5px; }

    .pyg-c, .pyg-cm, .pyg-c1, .pyg-cs, .pyg-ge, .pyg-sd { font-style: normal; }
    .pyg-err { border: none; }
</style>
</head>
<body>
<h1>
    <a href=\"/\">[incise.org]</a>
    $title
    <span class=\"titledate\">$titledate</span>
</h1>
"

