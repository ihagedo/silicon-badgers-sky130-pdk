# SiliconBadgers sky130 PDK

SkyWater 130 nm files for the SiliconBadgers flows ([flow-kit](https://github.com/ihagedo/flow-kit) and the courses), with one folder per tool set. Everything here is openly licensed.

| Folder | Used by | Cell library | What is inside |
|---|---|---|---|
| `open/` | Track A (open-source tools) | `sky130_fd_sc_hd` | OpenROAD-flow-scripts platform `sky130hd/`: Liberty (tt), LEF, GDS, power-grid and tap scripts, KLayout DRC/LVS decks; cell simulation models |
| `synopsys/` | Track B2 (Synopsys) | `sky130_fd_sc_hd` | Liberty (tt/ss/ff), LEF, GDS, CDL, Verilog; IC Compiler II technology file, ITF and layer maps; `make_views.sh` builds the `.db`, TLU+/nxtgrd and NDM views |

Track B1 (Cadence) needs Cadence's sky130 library and decks, which can't be redistributed, so they aren't included. flow-kit's Track B1 page lists the files to put in a `cadence/` folder here.

## Use

Clone this repo next to the flow or course repo. The flows look for it in a folder named `silicon-badgers-sky130-pdk`; to keep it somewhere else, set `SB_PDK` to its path.

Track B2 needs views built once with your Synopsys tools: see [synopsys/README.md](synopsys/README.md).

## Licenses and sources

- SkyWater cell library files: Apache-2.0 (`LICENSE.SkyWater` in each folder).
- OpenROAD-flow-scripts platform scripts: BSD-3-Clause (`open/LICENSE.ORFS`).
- Files written for this PDK: Apache-2.0 ([LICENSE](LICENSE)). These are the `synopsys/tech/` files, `make_views.sh`, the physical-only Liberty stubs and the patches. The `synopsys/tech/` files are written from SkyWater's published design rules, process stack and the cell library's technology LEF.
- `UPSTREAM.md` in each folder gives the source of every file and every local change.
