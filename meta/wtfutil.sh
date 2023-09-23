#!/bin/bash

VERSION="0.43.0"
ARCH="linux_amd64"
NAME="wtf_${VERSION}_${ARCH}"
ARCHIVE_URL="https://github.com/wtfutil/wtf/releases/download/v$VERSION/${NAME}.tar.gz"
ARCHIVE_FILE="${NAME}.tar.gz"
BIN="$HOME/.local/bin"

cd /tmp
wget -qO "$ARCHIVE_FILE" "$ARCHIVE_URL"
tar -xzf "$ARCHIVE_FILE"
mv "${NAME}/wtfutil" "$BIN/wtf"

