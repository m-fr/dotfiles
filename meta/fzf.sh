#!/bin/bash

VERSION="0.66.1"
ARCH="linux_amd64"
NAME="fzf-${VERSION}-${ARCH}"
ARCHIVE_URL="https://github.com/junegunn/fzf/releases/download/v${VERSION}/${NAME}.tar.gz"
ARCHIVE_FILE="${NAME}.tar.gz"
BIN="$HOME/.local/bin"

cd /tmp
curl -fsSLo "${ARCHIVE_FILE}" "${ARCHIVE_URL}"
tar -xzf "$ARCHIVE_FILE" fzf
mv fzf "$BIN/fzf"

