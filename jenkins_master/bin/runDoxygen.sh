#!/bin/bash +x

echo "# BRANCHNAME"
BRANCHNAME=$(/bin/sed 's/^origin\///' <<< "$GIT_BRANCH")
#echo ${BRANCHNAME}

echo "# DOCDIR"
DOCDIR="$WORKSPACE/doc/$BRANCHNAME"
#echo ${DOCDIR}

echo "# DESTINATION"
DESTINATION="/apidocs/$BRANCHNAME"
#echo ${DESTINATION}

if [ -d "$DOCDIR" ]; then
    rm -rf "$DOCDIR"
fi
mkdir -p "$DOCDIR"

# Prepare template, that SSI of branch-navi works everywhere.
sed -i "s/<!--#include virtual=\"navi.html\" -->/<!--#include virtual=\"\/$BRANCHNAME\/navi.html\" -->/g" "$WORKSPACE/doxygen-assets/header.html"

echo "### DOXYGEN CONFIG ###"
(cat "$WORKSPACE/Doxyfile" ; echo "OUTPUT_DIRECTORY = \"$(printf %q "$DOCDIR")\"")|cat
echo ""

echo "### GENERATING API DOC ###"
(cat "$WORKSPACE/Doxyfile" ; echo "OUTPUT_DIRECTORY = \"$(printf %q "$DOCDIR")\"")|doxygen -

if [ -d "$DESTINATION" ]; then
	echo "Clean up $DESTINATION"
    rm -rf "$DESTINATION"
fi
cp -R "$DOCDIR" "$DESTINATION"

# Generate a SELECT-navi from all directories in /apidocs.
/usr/local/bin/makeApiNav.sh /apidocs "$DESTINATION/navi.html" "$BRANCHNAME"
