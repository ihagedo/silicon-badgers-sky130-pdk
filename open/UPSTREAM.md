# Upstream

| | |
|---|---|
| Source | https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts |
| Commit | `babdf6e26cac84a79f7814a5c61c53ee84f43994` (2026-10-05) |
| Path | `flow/platforms/sky130hd` |
| Matching OpenROAD | `91e5f5ff2f198fd130e8915c8ad4408b56987fa4` |
| Matching Yosys | `a5af9d690a43744bf6b2cc3dea2717c16b54621c` |

## Cell simulation models

`verilog/primitives.v` and `verilog/sky130_fd_sc_hd.v`: the SkyWater functional models of sky130_fd_sc_hd (Apache-2.0, see `LICENSE.SkyWater`), from open_pdks `1689ac3f2dc763876eaf967227c7dfe831b031ae` (`sky130A/libs.ref/sky130_fd_sc_hd/verilog`). ORFS does not ship them; gate-level simulation needs them.

## Local changes

- `sky130hd/rcx_patterns.rules`: real copy of `flow/platforms/sky130hs/rcx_patterns.rules` (a symlink upstream).
- `verilog/primitives.v`: every `` `default_nettype none `` line is `` `default_nettype wire ``. VCS rejects the UDPs' non-ANSI port declarations under `none` (`Error-[IND] Identifier not declared`, 10 errors); Xcelium and Icarus accept either.
- `patches/lvs-tie-vnb-every-cell.patch`: the LVS deck ties VNB to VSS in every cell, not only the top. Without it a hardened block inside a larger design fails LVS (its substrate is a separate net).
- `patches/cdl-file-default.patch`: `CDL_FILE` is a default (`?=`), so a design can add the netlists of its macros for LVS.
