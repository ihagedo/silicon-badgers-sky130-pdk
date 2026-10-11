#!/bin/bash
# File:        update_from_orfs.sh
# Author:      Isaac Hagedorn
# Date:        2026-10-09
# Description: Replaces sky130hd/ with the sky130hd platform from an ORFS commit, then applies patches/. Review the diff, then update UPSTREAM.md.
set -euo pipefail
[ $# -eq 2 ] || { echo "usage: $0 <ORFS checkout> <ORFS commit>"; exit 2; }
ORFS=$1; REV=$2
HERE=$(cd "$(dirname "$0")" && pwd)
git -C "$ORFS" cat-file -e "$REV^{commit}"
rm -rf "$HERE/sky130hd"
git -C "$ORFS" archive "$REV" flow/platforms/sky130hd | tar -x -C "$HERE" --strip-components=2
# rcx_patterns.rules is a symlink into sky130hs/ upstream; keep a real copy
rm -f "$HERE/sky130hd/rcx_patterns.rules"
git -C "$ORFS" show "$REV:flow/platforms/sky130hs/rcx_patterns.rules" > "$HERE/sky130hd/rcx_patterns.rules"
# local fixes (listed in UPSTREAM.md)
for p in "$HERE"/patches/*.patch; do patch -s -p1 -d "$HERE" < "$p"; done
echo "sky130hd/ now matches ORFS $(git -C "$ORFS" rev-parse "$REV") plus patches/"
