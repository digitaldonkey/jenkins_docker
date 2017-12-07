#!/bin/bash

HEADER="<select id="version-selector" class='version-selector--select' onchange='location=this.value;'>"
FOOTER="</select>"
CONTENT=""

if [ -z "$1" ]
  then
    echo "Require a directory as first argument."
    exit 1
fi
if [ -z "$2" ]
  then
    echo "Require destination file as second argument."
    exit 1
fi
if [ -z "$3" ]
  then
    echo "Require current file as third argument."
    exit 1
fi



for DIR in `ls -d $1/*/`; do
    # echo "$DIR"
    DIR_NAME=$(echo "$DIR" |  rev | cut -d'/' -f-2 | rev)
    DIR_NAME=${DIR_NAME%/}
    #echo "$DIR_NAME"
    if [ "$DIR_NAME" = "$3" ]; then
      CONTENT="$CONTENT  <option selected='selected' value='/$DIR_NAME'>$DIR_NAME</option>\n"
    else
      CONTENT="$CONTENT  <option value='/$DIR_NAME'>$DIR_NAME</option>\n"
    fi
done

printf "$HEADER\n$CONTENT$FOOTER\n" > $2
cat $2
