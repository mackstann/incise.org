#!/bin/sh

# example:
#
# to turn /var/www/me/index.statiki into /var/www/me/index.html:
#
# $ sh path/to/statiki.sh me/index

WEBROOT="/var/www"
STATIKI="$WEBROOT/_statiki/statiki.py"
TEMPLATE="$WEBROOT/_statiki/template.html"
INPUT_EXT=".statiki"
OUTPUT_EXT=".html"

FILE_PATTERN="$1"

INPUT_FILE="$WEBROOT/$FILE_PATTERN$INPUT_EXT"
OUTPUT_FILE="$WEBROOT/$FILE_PATTERN$OUTPUT_EXT"

if [ ! -f "$INPUT_FILE" ]
then
  echo "doesn't exist: $INPUT_FILE"
  exit 1
fi

if [ ! -f "$STATIKI" ]
then
  echo "statiki not there: $STATIKI"
  exit 1
fi

if [ ! -f "$TEMPLATE" ]
then
  echo "template not there: $TEMPLATE"
  exit 1
fi

python "$STATIKI" "$TEMPLATE" < "$INPUT_FILE" > "$OUTPUT_FILE"

