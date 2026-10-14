/*
 * File:        sky130_fd_sc_hd.tf
 * Description: IC Compiler II technology file for SkyWater sky130 with the sky130_fd_sc_hd cells,
 *              written from open sources only (see ../UPSTREAM.md): layer rules from the SkyWater
 *              periphery design rules (rule IDs in the comments) and the sky130_fd_sc_hd technology LEF.
 *              Layer numbers follow the write_gds layer maps the flows already have
 *              (sky130_fd_sc_hd.icc2_gds.map; pd-onboarding flow/icc2/gds_layers.map): licon 1,
 *              li1 2, mcon 3, met1 4, via 5, met2 6, via2 7, met3 8, via3 9, met4 10, via4 11,
 *              met5 12, nwell 15, pwell 16.
 *              Routing direction and track offsets are not technology-file attributes in
 *              IC Compiler II; set them in the flow (tech LEF: li1 V 0.23, met1 H 0.17, met2 V 0.23,
 *              met3 H 0.34, met4 V 0.46, met5 H 1.70).
 * License:     Apache-2.0
 */

Technology {
	name			= "sky130_open"
	unitTimeName		= "ns"
	timePrecision		= 1000
	unitLengthName		= "micron"
	lengthPrecision		= 1000
	gridResolution		= 5		/* 0.005 um manufacturing grid (tech LEF MANUFACTURINGGRID) */
	unitVoltageName		= "v"
	voltagePrecision	= 1000000
	unitCurrentName		= "ma"
	currentPrecision	= 1000
	unitPowerName		= "mw"
	powerPrecision		= 1000000
	unitResistanceName	= "kohm"
	resistancePrecision	= 1000000
	unitCapacitanceName	= "pf"
	capacitancePrecision	= 1000000
	unitInductanceName	= "nh"
	inductancePrecision	= 100
}

/* placement sites: tech LEF SITE unithd (0.46 x 2.72) and unithddbl; the core site is named "unit", the name
   the IC Compiler II router looks for (ZRT-814 otherwise); Library Manager moves the LEF cells from unithd to it */
Tile "unit" {
	width			= 0.46
	height			= 2.72
}
Tile "unitdbl" {
	width			= 0.46
	height			= 5.44
}

/* nwell, GDS 64/20 */
Layer "nwell" {
	layerNumber		= 15
	maskName		= "nwell"
	isDefaultLayer		= 1
}
/* pwell, GDS 64/44 (tech LEF layer; the cells draw it as LEF obstruction only) */
Layer "pwell" {
	layerNumber		= 16
	maskName		= "pwell"
	isDefaultLayer		= 1
}
/* licon, GDS 66/44 (cut from diff/poly to li1, inside the cells only) */
Layer "licon" {
	layerNumber		= 1
	maskName		= "polyCont"
	isDefaultLayer		= 1
}
/* li1 (local interconnect), GDS 67/20 */
Layer "li1" {
	layerNumber		= 2
	maskName		= "metal1"
	isDefaultLayer		= 1
	pitch			= 0.46		/* tech LEF PITCH 0.46 (vertical) */
	defaultWidth		= 0.17		/* tech LEF WIDTH */
	minWidth		= 0.17		/* li.1 */
	minSpacing		= 0.17		/* li.3 */
	minArea			= 0.0561		/* li.6 */
}
/* mcon (li1 to met1), GDS 67/44 */
Layer "mcon" {
	layerNumber		= 3
	maskName		= "via1"
	isDefaultLayer		= 1
	minWidth		= 0.17		/* ct.1: square 0.17 cut */
	minSpacing		= 0.19		/* ct.2 */
}
/* met1, GDS 68/20 */
Layer "met1" {
	layerNumber		= 4
	maskName		= "metal2"
	isDefaultLayer		= 1
	pitch			= 0.34		/* tech LEF PITCH (horizontal) */
	defaultWidth		= 0.14		/* tech LEF WIDTH */
	minWidth		= 0.14		/* m1.1 */
	minSpacing		= 0.14		/* m1.2 */
	minArea			= 0.083		/* m1.6 */
	minEnclosedArea		= 0.14		/* m1.7: hole area */
	fatTblDimension		= 2		/* m1.3a/b: 0.28 to metal wider than 3 um ("huge_met1") */
	fatTblThreshold		= (0, 3)
	fatTblSpacing		= (0.14, 0.28,
				   0.28, 0.28)
}
/* via (met1 to met2), GDS 68/44 */
Layer "via" {
	layerNumber		= 5
	maskName		= "via2"
	isDefaultLayer		= 1
	minWidth		= 0.15		/* via.1a: square 0.15 cut */
	minSpacing		= 0.17		/* via.2 */
}
/* met2, GDS 69/20 */
Layer "met2" {
	layerNumber		= 6
	maskName		= "metal3"
	isDefaultLayer		= 1
	pitch			= 0.46		/* tech LEF PITCH (vertical) */
	defaultWidth		= 0.14		/* tech LEF WIDTH */
	minWidth		= 0.14		/* m2.1 */
	minSpacing		= 0.14		/* m2.2 */
	minArea			= 0.0676		/* m2.6 */
	minEnclosedArea		= 0.14		/* m2.7: hole area */
	fatTblDimension		= 2		/* m2.3a/b: 0.28 to metal wider than 3 um */
	fatTblThreshold		= (0, 3)
	fatTblSpacing		= (0.14, 0.28,
				   0.28, 0.28)
}
/* via2 (met2 to met3), GDS 69/44 */
Layer "via2" {
	layerNumber		= 7
	maskName		= "via3"
	isDefaultLayer		= 1
	minWidth		= 0.2		/* via2.1a: square 0.2 cut */
	minSpacing		= 0.2		/* via2.2 */
}
/* met3, GDS 70/20 (hole-area rule m3.7 applies to the copper flow only) */
Layer "met3" {
	layerNumber		= 8
	maskName		= "metal4"
	isDefaultLayer		= 1
	pitch			= 0.68		/* tech LEF PITCH (horizontal) */
	defaultWidth		= 0.3		/* tech LEF WIDTH */
	minWidth		= 0.3		/* m3.1 */
	minSpacing		= 0.3		/* m3.2 */
	minArea			= 0.24		/* m3.6 */
	fatTblDimension		= 2		/* m3.3c/d: 0.4 to metal wider than 3 um */
	fatTblThreshold		= (0, 3)
	fatTblSpacing		= (0.3, 0.4,
				   0.4, 0.4)
}
/* via3 (met3 to met4), GDS 70/44 */
Layer "via3" {
	layerNumber		= 9
	maskName		= "via4"
	isDefaultLayer		= 1
	minWidth		= 0.2		/* via3.1: square 0.2 cut */
	minSpacing		= 0.2		/* via3.2 */
}
/* met4, GDS 71/20 (hole-area rule m4.7 applies to the copper flow only) */
Layer "met4" {
	layerNumber		= 10
	maskName		= "metal5"
	isDefaultLayer		= 1
	pitch			= 0.92		/* tech LEF PITCH (vertical) */
	defaultWidth		= 0.3		/* tech LEF WIDTH */
	minWidth		= 0.3		/* m4.1 */
	minSpacing		= 0.3		/* m4.2 */
	minArea			= 0.24		/* m4.4a */
	fatTblDimension		= 2		/* m4.5a/b: 0.4 to metal wider than 3 um */
	fatTblThreshold		= (0, 3)
	fatTblSpacing		= (0.3, 0.4,
				   0.4, 0.4)
}
/* via4 (met4 to met5), GDS 71/44 */
Layer "via4" {
	layerNumber		= 11
	maskName		= "via5"
	isDefaultLayer		= 1
	minWidth		= 0.8		/* via4.1: square 0.8 cut */
	minSpacing		= 0.8		/* via4.2 */
}
/* met5, GDS 72/20 */
Layer "met5" {
	layerNumber		= 12
	maskName		= "metal6"
	isDefaultLayer		= 1
	pitch			= 3.4		/* tech LEF PITCH (horizontal) */
	defaultWidth		= 1.6		/* tech LEF WIDTH */
	minWidth		= 1.6		/* m5.1 */
	minSpacing		= 1.6		/* m5.2 */
	minArea			= 4		/* m5.4 */
}

/* vias: the distinct tech LEF via definitions (the _M/_MR variants that repeat another shape are left out); enclosures checked against the periphery rules named per via */
ContactCode "L1M1_PR" {		/* ct.4 (li1 0), m1.4 0.03 / m1.5 0.06 */
	contactCodeNumber	= 1
	cutLayer		= "mcon"
	lowerLayer		= "li1"
	upperLayer		= "met1"
	isDefaultContact	= 1
	cutWidth		= 0.17
	cutHeight		= 0.17
	lowerLayerEncWidth	= 0
	lowerLayerEncHeight	= 0
	upperLayerEncWidth	= 0.06
	upperLayerEncHeight	= 0.03
	minCutSpacing		= 0.19
}
ContactCode "L1M1_PR_R" {		/* ct.4 (li1 0), m1.4 0.03 / m1.5 0.06 */
	contactCodeNumber	= 2
	cutLayer		= "mcon"
	lowerLayer		= "li1"
	upperLayer		= "met1"
	isDefaultContact	= 1
	cutWidth		= 0.17
	cutHeight		= 0.17
	lowerLayerEncWidth	= 0
	lowerLayerEncHeight	= 0
	upperLayerEncWidth	= 0.03
	upperLayerEncHeight	= 0.06
	minCutSpacing		= 0.19
}
ContactCode "L1M1_PR_C" {		/* ct.4 (li1 0), m1.4 0.03 / m1.5 0.06 */
	contactCodeNumber	= 3
	cutLayer		= "mcon"
	lowerLayer		= "li1"
	upperLayer		= "met1"
	isDefaultContact	= 1
	cutWidth		= 0.17
	cutHeight		= 0.17
	lowerLayerEncWidth	= 0
	lowerLayerEncHeight	= 0
	upperLayerEncWidth	= 0.06
	upperLayerEncHeight	= 0.06
	minCutSpacing		= 0.19
}
ContactCode "M1M2_PR" {		/* via.4a 0.055 / via.5a 0.085 (met1), m2.4 0.055 / m2.5 0.085 (met2) */
	contactCodeNumber	= 4
	cutLayer		= "via"
	lowerLayer		= "met1"
	upperLayer		= "met2"
	isDefaultContact	= 1
	cutWidth		= 0.15
	cutHeight		= 0.15
	lowerLayerEncWidth	= 0.085
	lowerLayerEncHeight	= 0.055
	upperLayerEncWidth	= 0.055
	upperLayerEncHeight	= 0.085
	minCutSpacing		= 0.17
}
ContactCode "M1M2_PR_R" {		/* via.4a 0.055 / via.5a 0.085 (met1), m2.4 0.055 / m2.5 0.085 (met2) */
	contactCodeNumber	= 5
	cutLayer		= "via"
	lowerLayer		= "met1"
	upperLayer		= "met2"
	isDefaultContact	= 1
	cutWidth		= 0.15
	cutHeight		= 0.15
	lowerLayerEncWidth	= 0.055
	lowerLayerEncHeight	= 0.085
	upperLayerEncWidth	= 0.085
	upperLayerEncHeight	= 0.055
	minCutSpacing		= 0.17
}
ContactCode "M1M2_PR_M" {		/* via.4a 0.055 / via.5a 0.085 (met1), m2.4 0.055 / m2.5 0.085 (met2) */
	contactCodeNumber	= 6
	cutLayer		= "via"
	lowerLayer		= "met1"
	upperLayer		= "met2"
	isDefaultContact	= 1
	cutWidth		= 0.15
	cutHeight		= 0.15
	lowerLayerEncWidth	= 0.085
	lowerLayerEncHeight	= 0.055
	upperLayerEncWidth	= 0.085
	upperLayerEncHeight	= 0.055
	minCutSpacing		= 0.17
}
ContactCode "M1M2_PR_MR" {		/* via.4a 0.055 / via.5a 0.085 (met1), m2.4 0.055 / m2.5 0.085 (met2) */
	contactCodeNumber	= 7
	cutLayer		= "via"
	lowerLayer		= "met1"
	upperLayer		= "met2"
	isDefaultContact	= 1
	cutWidth		= 0.15
	cutHeight		= 0.15
	lowerLayerEncWidth	= 0.055
	lowerLayerEncHeight	= 0.085
	upperLayerEncWidth	= 0.055
	upperLayerEncHeight	= 0.085
	minCutSpacing		= 0.17
}
ContactCode "M1M2_PR_C" {		/* via.4a 0.055 / via.5a 0.085 (met1), m2.4 0.055 / m2.5 0.085 (met2) */
	contactCodeNumber	= 8
	cutLayer		= "via"
	lowerLayer		= "met1"
	upperLayer		= "met2"
	isDefaultContact	= 1
	cutWidth		= 0.15
	cutHeight		= 0.15
	lowerLayerEncWidth	= 0.085
	lowerLayerEncHeight	= 0.085
	upperLayerEncWidth	= 0.085
	upperLayerEncHeight	= 0.085
	minCutSpacing		= 0.17
}
ContactCode "M2M3_PR" {		/* via2.4 0.04 / via2.5 0.085 (met2), m3.4 0.065 (met3) */
	contactCodeNumber	= 9
	cutLayer		= "via2"
	lowerLayer		= "met2"
	upperLayer		= "met3"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.04
	lowerLayerEncHeight	= 0.085
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M2M3_PR_R" {		/* via2.4 0.04 / via2.5 0.085 (met2), m3.4 0.065 (met3) */
	contactCodeNumber	= 10
	cutLayer		= "via2"
	lowerLayer		= "met2"
	upperLayer		= "met3"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.085
	lowerLayerEncHeight	= 0.04
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M2M3_PR_C" {		/* via2.4 0.04 / via2.5 0.085 (met2), m3.4 0.065 (met3) */
	contactCodeNumber	= 11
	cutLayer		= "via2"
	lowerLayer		= "met2"
	upperLayer		= "met3"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.085
	lowerLayerEncHeight	= 0.085
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M3M4_PR" {		/* via3.4 0.06 / via3.5 0.09 (met3), m4.3 0.065 (met4) */
	contactCodeNumber	= 12
	cutLayer		= "via3"
	lowerLayer		= "met3"
	upperLayer		= "met4"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.09
	lowerLayerEncHeight	= 0.06
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M3M4_PR_R" {		/* via3.4 0.06 / via3.5 0.09 (met3), m4.3 0.065 (met4) */
	contactCodeNumber	= 13
	cutLayer		= "via3"
	lowerLayer		= "met3"
	upperLayer		= "met4"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.06
	lowerLayerEncHeight	= 0.09
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M3M4_PR_C" {		/* via3.4 0.06 / via3.5 0.09 (met3), m4.3 0.065 (met4) */
	contactCodeNumber	= 14
	cutLayer		= "via3"
	lowerLayer		= "met3"
	upperLayer		= "met4"
	isDefaultContact	= 1
	cutWidth		= 0.2
	cutHeight		= 0.2
	lowerLayerEncWidth	= 0.09
	lowerLayerEncHeight	= 0.09
	upperLayerEncWidth	= 0.065
	upperLayerEncHeight	= 0.065
	minCutSpacing		= 0.2
}
ContactCode "M4M5_PR" {		/* via4.4 0.19 (met4), m5.3 0.31 (met5) */
	contactCodeNumber	= 15
	cutLayer		= "via4"
	lowerLayer		= "met4"
	upperLayer		= "met5"
	isDefaultContact	= 1
	cutWidth		= 0.8
	cutHeight		= 0.8
	lowerLayerEncWidth	= 0.19
	lowerLayerEncHeight	= 0.19
	upperLayerEncWidth	= 0.31
	upperLayerEncHeight	= 0.31
	minCutSpacing		= 0.8
}
