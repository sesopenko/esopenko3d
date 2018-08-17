include <c_scs8uu.scad>;

// Use calipers to measure the outer distance between your two linear rods
c_a8_linearRodDistanceOuter = 54;

// Enter the width of your linear rods
c_a8_linearRodWidth = 8;

// END INPUT VARIABLES FOR PRINTER DIMENSIONS

c_a8_linearRodGapCenter = c_a8_linearRodDistanceOuter - c_a8_linearRodWidth;


function c_a8_xBearingGap() = c_a8_linearRodGapCenter - ((c_scs8uu_bearingHeight / 2) * 2);
