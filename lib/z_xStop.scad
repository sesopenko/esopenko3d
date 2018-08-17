include <c_scs8uu.scad>

module z_xStop(stopDistance) {
    // distance from top of highest x linear rod to top of carriage
    stopHeight = 13.6;
    // Thickness of the part screwing on to the carriage
    stopAttachemntDepth = 2;
    carriageDepth = 4;



    stopDepth = c_scs8uu_bearing_depth + carriageDepth;

    attachmentWidth = 12;
    attachmentHeight = stopHeight;

    screwDiameter = 3.76;

    union() {
        cube([stopDistance, stopDepth, stopHeight]);
        translate([stopDistance, 0,  stopHeight - attachmentHeight]) {
            attachment(attachmentWidth, stopAttachemntDepth, attachmentHeight, screwDiameter);
        }
    }
    
    
}

module attachment(attachmentWidth, attachmentDepth, attachmentHeight, screwDiameter) {
    screwHoleAllowance = 0.3;
    screwRadius = (screwDiameter + screwHoleAllowance) / 2;
    screwHoleCenterHeightFromtop = 5.6;
    screwHoleCenterDistanceFromEdge = 6;
    difference() {
        cube([attachmentWidth, attachmentDepth, attachmentHeight]);
        translate([screwHoleCenterDistanceFromEdge, 0, attachmentHeight - screwHoleCenterHeightFromtop]) {
            rotate([-90, 0, 0]) {
                cylinder(attachmentDepth + 1, screwRadius, screwRadius, $fs = 0.2);
            }
        }
        
    }
    
    
    
}