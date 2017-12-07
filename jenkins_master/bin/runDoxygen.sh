#!/bin/bash +x

echo "# BRANCHNAME"
BRANCHNAME=$(/bin/sed 's/^origin\///' <<< "$GIT_BRANCH")
#echo ${BRANCHNAME}

echo "# WORKDIR"
WORKDIR="$WORKSPACE/doc/$BRANCHNAME"
#echo ${WORKDIR}

echo "# DESTINATION"
DESTINATION="/apidocs/$BRANCHNAME"
#echo ${DESTINATION}

if [ -d "$WORKDIR" ]; then
    rm -rf "$WORKDIR"
fi
mkdir -p "$WORKDIR"


echo "### DOXYGEN CONFIG ###"
(cat "$WORKSPACE/Doxyfile" ; echo "OUTPUT_DIRECTORY = \"$(printf %q "$WORKDIR")\"")|cat
echo ""

echo "### GENERATING API DOC ###"
(cat "$WORKSPACE/Doxyfile" ; echo "OUTPUT_DIRECTORY = \"$(printf %q "$WORKDIR")\"")|doxygen -

if [ -d "$DESTINATION" ]; then
	echo "Clean up $DESTINATION"
    rm -rf "$DESTINATION"
fi
cp -R "$WORKDIR" "$DESTINATION"
