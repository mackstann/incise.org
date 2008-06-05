if [ "$1" = "py-libmpdclient2" ]
then
    spacey_name="$1"
else
    spacey_name=`echo "$1" | sed -e 's/-/ /g'`
fi

echo "
<html>
<head>
<title>incise.org - $1</title>
<style type="text/css">
    table, tr { background: #aaa; }
    td, th { background: white; }
    pre { background: #ffe; border: 1px solid #666; padding: 5px; }
    address { font-size: small; }
</style>
</head>
<body>
<h1><a href="/">[incise.org]</a> $spacey_name</h1>
"

