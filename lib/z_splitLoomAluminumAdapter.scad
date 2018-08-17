use <f_screws.scad>

loomM3HoleDistance = 10;

baseWidth = 60;
adapterDepth= 5.6;
extrusionWidth = 20;

riserHeight = 42;
riserWidth = 20;

riserOffsetForCenter = (baseWidth - riserWidth) / 2;

module z_splitLoomAluminumAdapter() {
    difference() {
        difference() {
            aluminumMount();
            loomMountHoles();
        }
        extrusionHoles();
    }
    
    
}

module aluminumMount() {
    union() {
        cube([baseWidth, adapterDepth, extrusionWidth]);
        translate([riserOffsetForCenter, 0, extrusionWidth]) {
            cube([riserWidth, adapterDepth, riserHeight]);
        }
    }
}

module loomMountHoles() {
    holesXPos = (baseWidth - loomM3HoleDistance) / 2;
    holeHeight = riserHeight + extrusionWidth - 7;
    translate([holesXPos, 0, holeHeight]) {
        m3Hole(adapterDepth, 0, 0);
        m3Hole(adapterDepth, loomM3HoleDistance, 0);
    }
    
}

module extrusionHoles() {
    translate([baseWidth / 2, 0, 10]) {
        m5Hole(adapterDepth);
    }
    translate([baseWidth - 10, 0, 10]) {
        m5Hole(adapterDepth);
    }
    translate([10, 0, 10]) {
        m5Hole(adapterDepth);
    }
}

module m3Hole(holeDepth, xPosition, zPosition) {
    hole(m3TapHole(), holeDepth,  xPosition, zPosition);
}

module m5Hole(holeDepth) {
    hole(m5ClearanceHole(), holeDepth,  0, 0);
}

module hole(holeDiameter, holeDepth, xPosition, zPosition) {
    holeRadius = holeDiameter / 2;
    translate([xPosition, 0, zPosition]) {
        rotate([-90, 0, 0]) {
            cylinder(holeDepth, holeRadius, holeRadius, $fs = 0.2);
        }
    }
}
