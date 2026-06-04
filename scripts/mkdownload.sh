#!/bin/bash

FILE=download.sh

rm -f $FILE

cat <<'EOF' > $FILE
#/bin/bash

download() {
    if [ ! -f "shared/$SRC" ]; then
        echo "Downloading $URL"
        pushd shared
        wget -O "$SRC" "$URL"
        if [ $? != 0 ]; then
            echo "Unable to download $URL"
        else
            if [ "$MD5" != "" ]; then
                if [ "$(md5sum $SRC)" != "$MD5  $SRC" ]; then
                    echo "BAD MD5 CHECKSUM : $SRC"
                fi
            fi
            if [ "$SHA256" != "" ]; then
                if [ "$(sha256sum $SRC)" != "$SHA256  $SRC" ]; then
                    echo "BAD SHA256 CHECKSUM : $SRC"
                fi
            fi
        fi
        popd
    fi

    SOURCE=
    URL=
    MD5=
    SHA256=
    VERSION=
}

EOF

readonly URI_REGEX='^(([^:/?#]+):)?(//((([^:/?#]+)@)?([^:/?#]+)(:([0-9]+))?))?(/([^?#]*))(\?([^#]*))?(#(.*))?'

parse_rpath () {
    [[ "$@" =~ $URI_REGEX ]] && echo "${BASH_REMATCH[11]}"
}


process () {
    if [ "$(basename $filename)" != "test.sh" \
            -a "$(basename $filename)" != "_utilities_stage1.sh" \
            -a "$(basename $filename)" != "_utilities_stage2.sh" \
            -a "$(basename $filename)" != "mkdownload.sh" \
            ]; then

    local version=$(grep "^VERSION=" $filename | sed s/VERSION=// -)

    local url=$(grep "^URL=" $filename | sed s/\\s// -)
    local source=$(grep "^SOURCE=" $filename | sed s/SOURCE=/SRC=/ -)
    local md5=$(grep "^MD5=" $filename)
    local sha256=$(grep "^SHA256=" $filename)
    local archive=$(grep "^load_archive " $filename)
    local filename=$1

    if [ "$version" != "" ]; then
        url=$(echo $url | sed s/.VERSION/$version/ -)
        source=$(echo $source | sed s/.VERSION/$version/ -)
    fi

    echo "# $filename" >> $FILE
    if [ "$url" != "" -a "$url" != "URL=" ]; then
        echo $url >> $FILE
        echo $source >> $FILE
        if [ "$md5" != "" -a "$md5" != "MD5=" ]; then
            echo $md5 >> $FILE
        fi
        if [ "$sha256" != "" ]; then
            echo $sha256 >> $FILE
        fi
        echo "download" >> $FILE
        echo >> $FILE
    fi

    if [ "$archive" != "" ]; then
        archives="$(echo $archive | \
            sed 's/load_archive\s*//g' - | \
            sed 's/\s*\\\s*/\n/g' -)"

        while read n; do
            echo "# archive $n" >> $FILE
            echo "URL=$n" >> $FILE
            echo "SRC=$(echo $n | sed "s/^.*\///" - )" >> $FILE
            echo "download" >> $FILE
            echo >> $FILE
        done <<< "$archives"
    fi

    fi
}

for filename in buildscripts/*.sh; do
    process $filename
done

chmod 755 $FILE
echo "$FILE has been created"
