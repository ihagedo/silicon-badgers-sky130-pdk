# synopsys: sky130_fd_sc_hd for Synopsys tools

Files for Track B2 (Design Compiler, IC Compiler II, StarRC, PrimeTime, Formality, VCS).

| Path | What |
|---|---|
| `sky130_fd_sc_hd/lib/` | Liberty timing: `tt_025C_1v80`, `ss_100C_1v60`, `ff_n40C_1v95` |
| `sky130_fd_sc_hd/lef/` | technology LEF (`sky130_fd_sc_hd.tlef`) and cell LEF |
| `sky130_fd_sc_hd/gds/`, `cdl/`, `verilog/` | cell layouts, netlists, simulation models (`primitives.v` + `sky130_fd_sc_hd.v`) |
| `tech/sky130_fd_sc_hd.tf` | IC Compiler II technology file |
| `tech/skywater130.nominal.itf` | interconnect stack (thicknesses, dielectrics, resistance) for StarRC and TLU+ |
| `tech/sky130_fd_sc_hd.starrc.map` | StarRC mapping file, LEF/DEF layer to ITF layer |
| `tech/sky130_fd_sc_hd.icc2_gds.map` | IC Compiler II `write_gds -layer_map` file (drawing, pin and label datatypes) |
| `make_views.sh` | builds `views/` on a licensed machine (below) |

## Build the views (once, on a machine with Synopsys licenses)

```
./make_views.sh
```

It writes `views/`:
- `sky130_fd_sc_hd__<corner>.db`: compiled Liberty (Library Compiler)
- `skywater130.nominal.tluplus`, `skywater130.nominal.nxtgrd`: extraction tables (grdgenxo)
- `sky130_fd_sc_hd.ndm`: IC Compiler II reference library (icc2_lm_shell)

`views/` is not committed (`.gitignore`).

Other technology files or another output folder: `TF=<file> ITF=<file> VIEWS=<folder> ./make_views.sh` (paths relative to this folder).

## Signoff DRC/LVS

No IC Validator decks exist for sky130. Use KLayout with `../open/sky130hd/drc/` and `../open/sky130hd/lvs/`.

Sources and licenses: `UPSTREAM.md`. The `tech/` files are written for this PDK from SkyWater's open documentation and the cell library's technology LEF (Apache-2.0).
