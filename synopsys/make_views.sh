#!/bin/bash
# File:        make_views.sh
# Author:      Isaac Hagedorn
# Date:        2026-10-09
# Description: Builds the Synopsys views into views/: Liberty .db, TLU+ and nxtgrd extraction tables, and the ICC2 NDM library. Needs lc_shell, grdgenxo and icc2_lm_shell on PATH.
#              Technology files and output folder (environment, relative to this folder; default in brackets):
#              TF [tech/sky130_fd_sc_hd.tf], ITF [tech/skywater130.nominal.itf], VIEWS [views].
#              The output file names are the same for every set.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
LIB=$HERE/sky130_fd_sc_hd
abspath() { case $1 in /*) echo "$1" ;; *) echo "$HERE/$1" ;; esac; }
TF=$(abspath "${TF:-tech/sky130_fd_sc_hd.tf}")
ITF=$(abspath "${ITF:-tech/skywater130.nominal.itf}")
V=$(abspath "${VIEWS:-views}")
mkdir -p "$V"
CORNERS="tt_025C_1v80 ss_100C_1v60 ff_n40C_1v95"

# 1. Liberty -> .db (the library name inside each .lib is sky130_fd_sc_hd__<corner>)
# The fill/tap cells live only in the LEF, not in the characterized Liberty, so merge
# the physical-only cell blocks (sky130_fd_sc_hd__phys.lib) into each corner library
# before compiling. They inherit the corner's voltage_map, so the ICC2 NDM includes
# them with consistent rails (needed for create_tap_cells and filler insertion).
PHYS=$LIB/lib/sky130_fd_sc_hd__phys.lib
for c in $CORNERS; do
  merged=$V/_merged_$c.lib
  head -n -1 "$LIB/lib/sky130_fd_sc_hd__$c.lib" > "$merged"   # drop the closing '}'
  cat "$PHYS" >> "$merged"
  echo "}" >> "$merged"
  lc_shell -no_init -x "read_lib $merged; \
    write_lib sky130_fd_sc_hd__$c -format db -output $V/sky130_fd_sc_hd__$c.db; exit"
  rm -f "$merged"
done

# 2. ITF -> TLU+ (IC Compiler II) and nxtgrd (StarRC)
# grdgenxo -itf2TLUPlus exits 1 even after "Done. (GRD-0062)", so check for a fresh output file instead
(cd "$V" && rm -f skywater130.nominal.tluplus \
  && { grdgenxo -itf2TLUPlus -i "$ITF" -o skywater130.nominal.tluplus || true; } \
  && test -s skywater130.nominal.tluplus)
# nxtgrd: grdgenxo takes the ITF as its only argument and names the output after TECHNOLOGY in the ITF
(cd "$V" && rm -f skywater130.nominal.nxtgrd && grdgenxo "$ITF" && mv -f "$(ls -t ./*.nxtgrd | head -1)" skywater130.nominal.nxtgrd)

# 3. NDM reference library from the technology file, cell LEF and .db files
DBS=""
for c in $CORNERS; do DBS="$DBS $V/sky130_fd_sc_hd__$c.db"; done
cat > "$V/make_ndm.tcl" <<EOF
create_workspace sky130_fd_sc_hd -technology $TF -flow normal
read_lef $LIB/lef/sky130_fd_sc_hd.lef
read_db [list $DBS]
# the three corners do not have the same timing arcs (316 differ)
check_workspace -allow_missing
commit_workspace -force -output $V/sky130_fd_sc_hd.ndm
exit
EOF
(cd "$V" && icc2_lm_shell -f make_ndm.tcl < /dev/null)

echo "views written to $V"
