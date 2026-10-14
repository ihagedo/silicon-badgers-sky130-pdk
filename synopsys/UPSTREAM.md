# Upstream

| Files | Source | License |
|---|---|---|
| `sky130_fd_sc_hd/**` | open_pdks `1689ac3f2dc763876eaf967227c7dfe831b031ae` (tag 1.0.608), `sky130A/libs.ref/sky130_fd_sc_hd/`; the technology LEF is `techlef/sky130_fd_sc_hd__nom.tlef` | Apache-2.0 (`LICENSE.SkyWater`) |
| `tech/sky130_fd_sc_hd.tf` | written for this PDK from open sources. Sites, pitches, default widths and via shapes: the technology LEF (`sky130_fd_sc_hd/lef/sky130_fd_sc_hd.tlef`). Widths, spacings, wide-metal spacing, minimum and hole areas, cut sizes, cut spacings and via enclosures: SkyWater periphery rules (rule ID next to each value). Layer numbers: those of the write_gds maps the flows already have | Apache-2.0 |
| `tech/skywater130.nominal.itf` | written for this PDK from open sources. Thicknesses, heights, dielectric layers and constants: SkyWater process stack diagram, except the NILD3 and NILD5 constants (4.08, 3.70 instead of 4.5, 4.1): the effective values of SkyWater's parallel-plate capacitance table for met1-met2 and met3-met4. Sheet and via resistance: SkyWater RCX resistance table; mcon 9.3 ohm from the technology LEF (the table's mcon entry, 152 ohm, is the poly contact value). Minimum width and spacing: periphery rules | Apache-2.0 |
| `tech/sky130_fd_sc_hd.starrc.map` | written for this PDK: StarRC mapping file, LEF/DEF layer to ITF layer (same names) | Apache-2.0 |
| `tech/sky130_fd_sc_hd.icc2_gds.map` | written for this PDK: `write_gds` layer map for `sky130_fd_sc_hd.tf`; GDS layer and datatype numbers from the SkyWater GDS layer table | Apache-2.0 |
| `sky130_fd_sc_hd/lib/sky130_fd_sc_hd__phys.lib` | authored for this PDK: physical-only Liberty stubs (fillers, well taps) for the cells that appear in the LEF but not the characterized Liberty; areas from LEF `SIZE`, pg_pins/types from the LEF and the `sky130_fd_sc_hd` Liberty. Merged into each corner library by `make_views.sh`. | Apache-2.0 (derived from the `sky130_fd_sc_hd` LEF) |

SkyWater sources of the `tech/` files: https://github.com/google/skywater-pdk commit `7198cf647113f56041e02abf3eb623692820c5e1`, `docs/rules/periphery/*.csv` (periphery rules), `docs/_static/metal_stack.svg` (process stack diagram), `docs/rules/rcx/resistance-values.tsv` (RCX resistance table), `docs/rules/rcx/capacitance-parallel.tsv` (parallel-plate capacitance table), `docs/rules/gds_layers.csv` (GDS layer table); Apache-2.0. Checked against, not copied from: open_pdks `0ec4fa67eade28cd0a4352c04df981840809427b` `sky130/magic/sky130.tech` (heights, sheet and contact resistance) and `../open/sky130hd/` (`setRC.tcl`, `drc/sky130hd.lydrc`).

Choices in the `tech/` files that the sources leave open:
- ITF: away from met5 the diagram gives only the total passivation (0.3777 um); split as TOPOX 0.09 + TOPNIT 0.2877. NILD3_C and NILD4_C (0.03 on the met1 and met2 sidewalls) are 0.001 thick elsewhere, because grdgenxo needs a thickness. No temperature coefficients.
- Technology file: routing direction and track offset are not technology-file attributes in IC Compiler II; the flow sets them (`pd-flow` `common.tcl`). The core site (tech LEF `unithd`) is named `unit`, the name the IC Compiler II router expects (ZRT-814 otherwise); Library Manager moves the cells to it. licon is a layer without contact code (the router's ZRT-022 warning about it is harmless; without the layer IC Compiler II spreads the pd-flow tile's placement for congestion: 456 vs 363 mm half-perimeter wire length). LEF vias that repeat another via's shape are left out. Hole-area rules on met1 and met2 only (m3.7, m4.7 are copper-flow rules).

## Local changes

- `sky130_fd_sc_hd/verilog/primitives.v`: every `` `default_nettype none `` line is `` `default_nettype wire ``, as in `../open/verilog/primitives.v`. VCS rejects the UDPs' non-ANSI port declarations under `none` (`Error-[IND] Identifier not declared`).
