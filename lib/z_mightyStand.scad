slotAllowance = 1;
mightyWidth = 78 + slotAllowance;
// depth does not include embelishment sticking out of bottom of unit
mightyDepth = 24 + slotAllowance;
slotDepth = 44;
standWallWidth = 3;
controlWidth = 53;
controlHeight = 28;
controlDistanceFromUnitBottom = 19;

powerButtonDiameter = 9;
// Distance from center of button to bottom of unit.
powerButtonDistanceFromUnitBottom = 28;
powerButtonProtrusionAllowance = 10;

// The triangular Protrusion embelishment at the bottom, under the screen.
// thickness including Protrusion minus thickness of unit
lowerProtrusionDepth = 25.5 - 23.8;
lowerProtrusionWidth = 26.8;
lowerProtrusionDistanceFromUnitBottom = 3;

module z_mightyStand() {
    difference() {
        standShell();
        translate([standWallWidth, standWallWidth, standWallWidth]) {
            unitSlot(slotDepth);
        }
        
    }
}

module standShell() {
    shellDepth = mightyDepth + standWallWidth * 2;
    shellWidth = mightyWidth + standWallWidth * 2;
    shellHeight = slotDepth + standWallWidth;
    difference() {
        union() {
            translate([shellDepth / 2, shellDepth / 2, 0]) {
                shellCylinder(shellDepth);
            }
            translate([shellDepth / 2, 0, 0]) {
                cube([shellWidth - shellDepth, shellDepth, shellHeight]);
            }
            translate([shellDepth / 2 + shellWidth - shellDepth, shellDepth / 2, 0]) {
                shellCylinder(shellDepth);
            }
        }
        shellSubtractions(shellWidth, shellDepth);
    }
}

module shellSubtractions(shellWidth, shellDepth) {
    translate([shellWidth / 2 - controlWidth / 2, 0, controlDistanceFromUnitBottom]) {
        controlWindow();
    }
    translate([0,  shellDepth / 2, powerButtonDiameter / 2 + standWallWidth + powerButtonDistanceFromUnitBottom]) {
        controlButtonSlot();
    }
    lowerProtrusion();
    
    
}

module lowerProtrusion() {
    protusionHeight = slotDepth - controlHeight;
    protrusionTranslateX = (mightyWidth + (standWallWidth * 2)) / 2 - lowerProtrusionWidth / 2;
    translate([protrusionTranslateX, standWallWidth + 1,  protusionHeight + standWallWidth + lowerProtrusionDistanceFromUnitBottom]) {
        rotate([180, 0, 0]) {
            linear_extrude(protusionHeight) {
                polygon([
                    [0, 0],
                    [lowerProtrusionWidth, 0],
                    [lowerProtrusionWidth / 2, lowerProtrusionDepth]
                ]);
            }
        }
    }
    
    
    
    
}

module shellCylinder(shellDepth) {
    radius = shellDepth / 2;
    cylinder(slotDepth + standWallWidth, radius, radius, $fn = 40);
}

module controlWindow() {
    cube([controlWidth, standWallWidth, controlHeight]);
}

module controlButtonSlot() {
    buttonRadius = powerButtonDiameter / 2;
    slotLength = slotDepth - controlDistanceFromUnitBottom;
    rotate([90, 0 , 90]) {
        cylinder(powerButtonProtrusionAllowance, buttonRadius, buttonRadius, $fs = 0.2);

    
        translate([-powerButtonDiameter / 2, 0]) {
            cube([powerButtonDiameter, slotLength, powerButtonProtrusionAllowance]);
        }
    }
    
    
}

module unitSlot(slotDepth) {
    translate([mightyDepth / 2, mightyDepth / 2, 0]) {
        cubeWidth = mightyWidth - mightyDepth;
        slotCylinder(slotDepth);
        translate([cubeWidth, 0, 0]) {
            slotCylinder(slotDepth);
        }
        
        translate([0, -mightyDepth / 2, 0]) {
            cube([cubeWidth, mightyDepth, slotDepth]);
        }
    }
}

module slotCylinder(slotDepth) {
    roundedSideRadius = mightyDepth / 2;

    cylinder(slotDepth, roundedSideRadius, roundedSideRadius, $fn = 40);
}