/*
@file
Renders a hotend mount backplate which mates with the X axis bearing blocks of the anet a8.
*/

use <SCS8UUHoles.scad>

// a8XBearingBlockPlate
// INPUT VARIABLES FOR PRINTER DIMENSIONS
// Use calipers to measure the outer distance between your two linear rods
linearRodDistanceOuter = 54;

// Enter the width of your linear rods
linearRodWidth = 8;

// END INPUT VARIABLES FOR PRINTER DIMENSIONS

linearRodGapCenter = linearRodDistanceOuter - linearRodWidth;

// @see https://www.trfastenings.com/Products/knowledgebase/Tables-Standards-Terminology/Tapping-Sizes-and-Clearance-Holes




module p_a8XBearingBlockPlate(topBearingGap, depth) {
    bearingWidth = 30;
    bearingHeight = 34;
    plateWidthExtra = 2;
    plateWidth = plateWidthExtra + bearingWidth + topBearingGap + bearingWidth + plateWidthExtra;
    lowerBearingXOffset = (plateWidth / 2) - (bearingWidth / 2);
    lowerBearingYOffset = linearRodGapCenter;

    // TODO:  calculate!
    height = plateWidthExtra + (bearingHeight / 2) + linearRodGapCenter + (bearingHeight / 2) + plateWidthExtra;
    difference() {
        cube([plateWidth, height, depth]);
        union() {
            // 2 bearings on top with their linear cylinders oriented horizontally
            translate([plateWidthExtra, plateWidthExtra, 0]) {
                translate([bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        SCS8UUHoles(depth);
                    }
                }
            }
            translate([plateWidthExtra + topBearingGap + bearingWidth, plateWidthExtra, 0]) {
                translate([bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        SCS8UUHoles(depth);
                    }
                }
            }
            translate([lowerBearingXOffset, lowerBearingYOffset, 0]) {
                translate([bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        SCS8UUHoles(depth, 2);
                    }
                }
            }
        }
    
    }
}
