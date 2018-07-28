module SCS8UUHoles(depth, tolerance = 0) {
    /*
               I             I 
    **************hole edge****************
    *          i             i            *
    *  O <-----i-------24----i-------> O  *
    *          i             i         ^  *
    *          i             i         |  *
    30         i             i         18 *
    *          i             i         |  *
    *          i             i         v  *
    *  O       i             i         O  *
    *          i             i            *
    ******************34*******************
               I             I
    */

    holeEdgeWidth = 34;
    solidEdgeLength = 30;
    holeEdgeScrewDistance = 24;
    solidEdgeScrewDistance = 18;
    
    firstHoleX = ((holeEdgeWidth - holeEdgeScrewDistance) / 2);
    firstHoleY = ((solidEdgeLength - solidEdgeScrewDistance) / 2);

    secondHoleX = firstHoleX + holeEdgeScrewDistance;
    secondHoleY = firstHoleY;

    thirdHoleX = firstHoleX;
    thirdHoleY = firstHoleY + solidEdgeScrewDistance;

    fourthHoleX = secondHoleX;
    fourthHoleY = thirdHoleY;
    
    translate([firstHoleX, firstHoleY, 0]) {
        SunkHoleM3Tolerabe(depth, tolerance);
    }

    translate([secondHoleX, secondHoleY, 0]) {
        SunkHoleM3Tolerabe(depth, tolerance);
    }

    translate([thirdHoleX, thirdHoleY, 0]) {
        SunkHoleM3Tolerabe(depth, tolerance);
    }

    translate([fourthHoleX, fourthHoleY, 0]) {
        SunkHoleM3Tolerabe(depth, tolerance);
    }
}

m3Clearance = 3.4;

module SunkHoleM3(depth) {
    screwHoleTolerance = 0.2;
    holeFragments = 25;
    screwHoleRadius = (m3Clearance + screwHoleTolerance * 2) / 2;
    screwHeadDepth = 2.2;
    m3screwHeadClearanceRadius = 6 / 2;
    translate([0, 0, depth]) {
        rotate([180,0,0]) {
            union() {
                cylinder(depth, screwHoleRadius, screwHoleRadius, $fn=holeFragments);
                cylinder(screwHeadDepth, m3screwHeadClearanceRadius, m3screwHeadClearanceRadius, $fn=holeFragments);
            }
        }
    }
}

/**
 * Creates an M3, counter sunk hole that extends a length for wide mechanical tolerance.
 *
 * @param depth
 *   How deep the hole should be
 * @param tolerance
 *   distance between the center of the two holes.
 */
module SunkHoleM3Tolerabe(depth, tolerance) {
    screwHoleTolerance = 0.2;
    holeFragments = 25;
    screwHoleRadius = (m3Clearance + screwHoleTolerance * 2) / 2;
    screwHeadDepth = 2.2;
    m3screwHeadClearanceRadius = 6 / 2;

    // draw 2 inner circles
    linear_extrude(depth) {
        CircleTolerableLinear(screwHoleRadius, tolerance, holeFragments);
    }

    translate([0, 0, depth - screwHeadDepth]) {
        linear_extrude(screwHeadDepth) {
            CircleTolerableLinear(m3screwHeadClearanceRadius, tolerance, holeFragments);
        }
    }
}

module CircleTolerableLinear(holeRadius, tolerance, holeFragments) {
    offset = (tolerance - (holeRadius * 4)) / 2;
    translate([-tolerance/2, 0, 0]) {
        hull() {
            circle(holeRadius, $fn=holeFragments);
            translate([tolerance, 0, 0]) {
                circle(holeRadius, $fn=holeFragments);
            }
        }
    }
}