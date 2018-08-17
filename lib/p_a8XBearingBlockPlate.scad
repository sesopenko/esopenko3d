/*
@file
Renders a hotend mount backplate which mates with the X axis bearing blocks of the anet a8.
*/

use <p_SCS8UUHoles.scad>;

include <c_scs8uu.scad>;
include <c_a8.scad>;

// a8XBearingBlockPlate
// INPUT VARIABLES FOR PRINTER DIMENSIONS
// Use calipers to measure the outer distance between your two linear rods
c_a8_linearRodDistanceOuter = 54;

// Enter the width of your linear rods
c_a8_linearRodWidth = 8;

// END INPUT VARIABLES FOR PRINTER DIMENSIONS

c_a8_linearRodGapCenter = c_a8_linearRodDistanceOuter - c_a8_linearRodWidth;

// @see https://www.trfastenings.com/Products/knowledgebase/Tables-Standards-Terminology/Tapping-Sizes-and-Clearance-Holes




module p_a8XBearingBlockPlate(topBearingGap, depth) {
    c_scs8uu_bearingWidth = 30;
    c_scs8uu_bearingHeight = 34;
    plateWidthExtra = 2;
    plateWidth = plateWidthExtra + c_scs8uu_bearingWidth + topBearingGap + c_scs8uu_bearingWidth + plateWidthExtra;
    lowerBearingXOffset = (plateWidth / 2) - (c_scs8uu_bearingWidth / 2);
    lowerBearingYOffset = c_a8_linearRodGapCenter;

    // TODO:  calculate!
    height = plateWidthExtra + (c_scs8uu_bearingHeight / 2) + c_a8_linearRodGapCenter + (c_scs8uu_bearingHeight / 2) + plateWidthExtra;
    difference() {
        cube([plateWidth, height, depth]);
        union() {
            // 2 bearings on top with their linear cylinders oriented horizontally
            translate([plateWidthExtra, plateWidthExtra, 0]) {
                translate([c_scs8uu_bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        p_SCS8UUHoles(depth);
                    }
                }
            }
            translate([plateWidthExtra + topBearingGap + c_scs8uu_bearingWidth, plateWidthExtra, 0]) {
                translate([c_scs8uu_bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        p_SCS8UUHoles(depth);
                    }
                }
            }
            translate([lowerBearingXOffset, lowerBearingYOffset, 0]) {
                translate([c_scs8uu_bearingWidth, 0, 0]) {
                    rotate([0, 0, 90]) {
                        p_SCS8UUHoles(depth, 2);
                    }
                }
            }
        }
    
    }
}
