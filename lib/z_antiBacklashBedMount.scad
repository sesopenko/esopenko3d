mountDiameter = 37.2;
mountDepth = 5;

backlashHousingDiameter = 20;
backlashHousingDepth = 18;

mountScrewHoleDiameter = 3.75;
mountScrewHoleDistanceToInner = 26.4;

// Attaches to 20/40
extrusionMountHeight = 40;

m5ClearanceHole = 5.5;
m3ClearanceHole = 3.4;
m5HoleWallWidth = 5;
m5HeadDiameter = 8.5;

attachmentWidth = mountDiameter + m5ClearanceHole * 2 + m5HoleWallWidth * 4;
attachmentDepth = 5.2;

holeHalfWidth = m5ClearanceHole / 2;
holeDistanceFromLeftEdge = holeHalfWidth + m5HoleWallWidth;
holeDistanceFromRightEdge = attachmentWidth - holeHalfWidth - m5HoleWallWidth;
// Middle of one section of the 2040 extrusion
holedistanceFromBottomEdge = extrusionMountHeight / 4;

module z_antiBacklashBedMount() {
    union() {
        extrusionPlate();
        leadRodNutMount();
    }
}

module extrusionPlate() {
    
    
    difference() {
        cube([attachmentWidth, attachmentDepth, extrusionMountHeight]);
        union() {
            m5Hole(holeDistanceFromLeftEdge, holedistanceFromBottomEdge);
            m5Hole(holeDistanceFromLeftEdge, extrusionMountHeight - 10);
            m5Hole(holeDistanceFromRightEdge, holedistanceFromBottomEdge);
            m5Hole(holeDistanceFromRightEdge, extrusionMountHeight - 10);
        }
    }
    
}

module m5Hole(x, z) {
    m5ClearanceHoleRadius = m5ClearanceHole / 2;
    translate([x, 0, z]) {
        rotate([-90, 0, 0]) {
            cylinder(attachmentDepth, m5ClearanceHoleRadius, m5ClearanceHoleRadius, $fs = 0.2);
        }
    }
}

module leadRodNutMount() {
    mountDepth = 10;
    mountRadius = mountDiameter / 2 + 1;
    mountBraceDepth = m5HoleWallWidth - ((m5HeadDiameter - m5ClearanceHole) / 2) - 1;
    sideBraceWidth = (attachmentWidth - (mountRadius * 2)) / 2;
    leadScrewRadius = 4;
    leadScrewAllowance = 0.5;
    leadScrewHoleRadius = leadScrewRadius + leadScrewAllowance;
    translate([attachmentWidth / 2, -mountRadius, extrusionMountHeight - mountDepth]) {
        difference() {
            union() {
                cylinder(mountDepth, mountRadius, mountRadius, $fs = 0.5);
                translate([-mountRadius, 0, 0]) {
                    cube([mountRadius * 2, mountRadius, mountDepth]);
                }
                translate([-mountRadius - sideBraceWidth, 0,  mountDepth - mountDepth]) {
                    sideBrace(sideBraceWidth, mountRadius, mountDepth);
                }
                translate([mountRadius + sideBraceWidth, 0, 0]) {
                    mirror([1, 0, 0]) {
                        sideBrace(sideBraceWidth, mountRadius, mountDepth);
                    }
                }
                bottomBrace(mountRadius, mountDepth);
            }
            union() {
                translate([-(mountScrewHoleDistanceToInner / 2), 0, 0]) {
                    cylinder(mountDepth, m3ClearanceHole / 2, m3ClearanceHole / 2, $fs = 0.2);
                }
                translate([mountScrewHoleDistanceToInner / 2, 0, 0]) {
                    cylinder(mountDepth, m3ClearanceHole / 2, m3ClearanceHole / 2, $fs = 0.2);
                }
            cylinder(mountDepth, leadScrewHoleRadius, leadScrewHoleRadius, $fs = 0.2);
                
            }
        }
        
    }
}

module sideBrace(sideBraceWidth, mountRadius, mountDepth) {
    m5HoleRadius = m5HeadDiameter / 2 + 0.5;
    translate([0, mountRadius, 0]) {
        difference() {
            linear_extrude(height = mountDepth) {
                polygon([[0, 0], [sideBraceWidth, -mountRadius], [sideBraceWidth, 0]]);
            }
            translate([holeDistanceFromLeftEdge, 0, mountDepth - holedistanceFromBottomEdge]) {
                rotate([90, 0, 0]) {
                    cylinder(100, m5HoleRadius, m5HoleRadius, $fs = 0.5);
                }
            }
        }
        
    }
    
}

module bottomBrace(mountRadius, mountDepth) {
    braceDepth = extrusionMountHeight - mountDepth;
    difference() {
        translate([-mountRadius, mountRadius, 0]) {
            rotate([-90, 0, -90]) {
                linear_extrude(height = mountRadius * 2) {
                    polygon([[0, 0], [mountRadius, 0], [0, braceDepth]]);
                }
            }
                
            
        }
        translate([0, 0, -extrusionMountHeight + mountDepth]) {
            cylinder(extrusionMountHeight - mountDepth, mountRadius, mountRadius, $fs = 0.5);
        }
        
    }
    
    
}
