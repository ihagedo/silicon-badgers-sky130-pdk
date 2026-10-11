# open: sky130hd for OpenROAD-flow-scripts

The SkyWater `sky130_fd_sc_hd` platform in OpenROAD-flow-scripts (ORFS) format, used by Track A.

```
make -C <ORFS>/flow PLATFORM=sky130hd PLATFORM_DIR=<this repo>/open/sky130hd DESIGN_CONFIG=<design>/config.mk
```

- Source and local changes: `UPSTREAM.md`.
- Pull a newer ORFS version: `./update_from_orfs.sh <ORFS checkout> <commit>`, check the diff, update `UPSTREAM.md`.
- Licenses: cell library files (`lib/`, `lef/`, `gds/`, `cdl/`) Apache-2.0 (`LICENSE.SkyWater`); ORFS scripts BSD-3-Clause (`LICENSE.ORFS`).
