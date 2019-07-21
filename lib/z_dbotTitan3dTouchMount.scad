/**
@file

DBot Titan 3D Touch Mount

This mount is designed to be compatible with the AC-Bot Titan mount for the Dbot, originally created by Sparreau:
https://www.thingiverse.com/thing:2287732

I tested it with a "3D Touch" but it should work with the original BLTouch.

Created by Sean Esopenko 2018

This is licensed Creative Commons Attribution - Share Alike
The license can be read here and should be included with this file:
http://creativecommons.org/licenses/by-sa/4.0/

**/

motorWidth = 42.3;
// Distance between each set of screws

motorMountHeight = 45;

// Thickness of plastic motor & extruder are mounted to
motorMountThickness = 4.2;

// Thickness of the plastic mounted to the wheeled gantry
gantryMountThickness = 3.96;

// The triangular bracket for the motor mount
motorAngleBracketDepth = 16;
motorAngleBracketThickness = gantryMountThickness;

// Measurements from the original model for the gantry mount screw holes.
// These are for the 2 holes on the top left and the 2 holes for the bottom left
// Mounting the angle brackets to the gantry.
originalModelScrewHole = 3.2;
// Distance between screw holes
originalModelScrewHoleDistance = 10.8;
originalModelScrewHoleDistanceLeftEdge = 1.9;

topGantryMountWidth = 43;
topGantryMountHeight = 7;

lowerGantryWidth = 24.8;

module z_dbotTitan3dTouchMount() {
    union() {
        gantryMounts();
        hotendHolder();
    }
    
}

module gantryMounts() {
    difference() {
        union() {
            lowerGantryMount();
            topGantryMount();
            centerGantryMount();
            cordHolder();
        }
    }   
}

module hotendHolder() {
    // measurements
    // Distance from left of gantry mount to center of hotend
    leftGantryToHotendCenter = 34;
    // Distance from top of heatsink to bottom of heating block
    heatsinkToHeatingBlockDistance = 40.1;
    // Inner diameter of the part gripped
    innerMountCylinderDiameter = 11.96;
    // Outer diameter of the part above & below the gripped cylinder
    outerMountCylinderDiameter = 16;
    // The height of the part that's gripped
    innerMountHeight = 6;
    // The height of the lower portion, below the gripped cylinder, to the radiator
    lowerMountCylinderHeight = 7;
    // The diameter of the radiator
    radiatorDiameter = 22;
    translate([0, 0, 0]) {
        hotendMount(innerMountCylinderDiameter, innerMountHeight, outerMountCylinderDiameter, radiatorDiameter, leftGantryToHotendCenter);
    }
}

module hotendMount(innerMountCylinderDiameter, innerMountHeight, outerMountCylinderDiameter, radiatorDiameter, leftGantryToHotendCenter) {
    // The extra distance on each side of the part gripping the hotend.
    hotendMountExtension = 12;
    // The target distance between the hotend and the gantry.
    targetGantryToHotendDistance = 3;
    hotendMountDepth = radiatorDiameter / 2 + targetGantryToHotendDistance;
    hotendMountWidth = innerMountCylinderDiameter + (hotendMountExtension * 2);
    cylinderAllowance = 0.2;
    hotendCenteringTranslationX = -motorAngleBracketDepth+ leftGantryToHotendCenter - (hotendMountWidth / 2);
    translate([hotendCenteringTranslationX, -hotendMountDepth, 0]) {
        difference() {
            hotendMountBody(hotendMountWidth, hotendMountDepth, innerMountHeight, innerMountCylinderDiameter);
            hotendMountBodyHardwareSubtractions(innerMountCylinderDiameter, innerMountHeight, hotendMountExtension, hotendMountWidth);
        }
        
    }
}

module hotendMountBody(hotendMountWidth, hotendMountDepth, innerMountHeight, innerMountCylinderDiameter) {
    difference() {
        cube([hotendMountWidth, hotendMountDepth, innerMountHeight]);
        translate([hotendMountWidth / 2, 0, 0]) {
            cylinder(h = innerMountHeight, r = (innerMountCylinderDiameter / 2) + 0.2);
        }
    }
}

module hotendMountBodyHardwareSubtractions(innerMountCylinderDiameter, innerMountHeight, hotendMountExtension, hotendMountWidth) {
    screwHoleDepth = innerMountCylinderDiameter + 2;
    nutPocketDepth = innerMountCylinderDiameter / 2;
    rotate([-90, 0, 0]) {
        translate([0, -innerMountHeight / 2, 0]) {
            translate([hotendMountExtension / 2, 0, 0]) {
                m3ScrewHole(screwHoleDepth);
            }
            translate([hotendMountWidth - hotendMountExtension / 2, 0, 0]) {
                m3ScrewHole(screwHoleDepth);
            }
        }
        translate([hotendMountExtension / 2, -innerMountHeight / 2, nutPocketDepth]) {
            hotendNutPocket();
        }
    }
}

module hotendNutPocket() {
    // m3 nut
    nutShortWidth = 5.5;
    nutLongWidth = 6.1;
    nutDepth = 2.24;
    nutPocketSocketLength = 8;
    translate([-nutPocketSocketLength, -nutShortWidth / 2, 0]) {
        cube([nutLongWidth + nutPocketSocketLength, nutShortWidth, nutDepth]);
    }
    
}

module cordHolder() {
    translate([-motorAngleBracketDepth, gantryMountThickness, motorMountHeight + topGantryMountHeight]) {
        rotate([90, 0, 0]) {
            cordHolderGeometry();
        }
        
    }
}

module cordHolderGeometry() {
    braceHeight = 3;
    braceWidth = 3;
    holderWidth = 6.5;
    holderDistanceFromLeft = 30;
    holderBaseHeight = 12;
    holderHeight = 34;

    rightTriangleWidth = topGantryMountWidth - holderWidth - holderDistanceFromLeft;

    tubeHolderMountThickness = 2.5;
    tubeHolderOuterDiameter = 17;
    tubeHolderZPos = gantryMountThickness - tubeHolderMountThickness + braceHeight;
    tubeHolderHeight = 15;

    holderBaseBottomX = holderDistanceFromLeft + (holderWidth - braceWidth) / 2;
    // left triangle
    difference() {
        union() {
            linear_extrude(gantryMountThickness) {
                polygon([
                    [0, 0],
                    [holderDistanceFromLeft, 0],
                    [holderDistanceFromLeft, holderBaseHeight],
                ]);
            }
            translate([holderDistanceFromLeft, 0, 0]) {
                cube([holderWidth, holderBaseHeight, gantryMountThickness]);
            }
            translate([holderDistanceFromLeft + holderWidth, 0, 0]) {
                linear_extrude(gantryMountThickness) {
                    polygon([
                        [0, 0],
                        [0, holderBaseHeight],
                        [rightTriangleWidth, 0]
                    ]);
                }
            }
            translate([holderDistanceFromLeft, holderBaseHeight, 0]) {
                cube([holderWidth, holderHeight, gantryMountThickness]);
            }
            translate([holderDistanceFromLeft + holderWidth / 2, holderBaseHeight + holderHeight - tubeHolderHeight, tubeHolderZPos]) {
                cordHolderTubeMount(tubeHolderMountThickness, tubeHolderOuterDiameter, tubeHolderHeight);
            }
            translate([holderDistanceFromLeft, holderBaseHeight + holderHeight - tubeHolderHeight, gantryMountThickness]) {
                cube([holderWidth, tubeHolderHeight, braceHeight]);
            }
            translate([holderBaseBottomX, holderBaseHeight, gantryMountThickness]) {
                cube([braceWidth, holderHeight, braceHeight]);
            }
            translate([0, 0, gantryMountThickness]) {
                linear_extrude(braceHeight) {
                    polygon([
                        [holderBaseBottomX, holderBaseHeight],
                        [9, 0],
                        [9 + braceWidth, 0],
                        [holderDistanceFromLeft, 5.6],
                        [holderDistanceFromLeft + 2, 5.6],
                        [37, 0],
                        [37 + braceWidth, 0],
                        [holderBaseBottomX + braceWidth, holderBaseHeight],
                    ]);
                }
            }
        }
        translate([holderDistanceFromLeft, holderBaseHeight + holderHeight - tubeHolderHeight + 2, gantryMountThickness]) {
            cordHolderZipTieHoles(holderWidth);
        }
    }  
}

module cordHolderZipTieHoles(holderWidth) {
    holeHeight = 1.5;
    zipTieWidth = 3.5;
    holeDistance = 7.4;
    cube([holderWidth, zipTieWidth, holeHeight]);
    translate([0, holeDistance]) {
        cube([holderWidth, zipTieWidth, holeHeight]);
    }
}

module cordHolderTubeMount(mountThickness, outerDiameter, holderHeight) {
    
    innerDiameter = outerDiameter - mountThickness * 2;

    translate([0, 0, outerDiameter / 2]) {
        rotate([-90, 0, 0]) {
            difference() {
                difference() {
                    cylinder(holderHeight, outerDiameter / 2, outerDiameter / 2, $fs = 0.2);
                    cylinder(holderHeight, innerDiameter / 2, innerDiameter / 2, $fs = 0.2);
                }
                translate([-outerDiameter / 2, -outerDiameter, 0]) {
                    cube([outerDiameter, outerDiameter, outerDiameter]);
                }
                
            }
        }
    }  
}

module bltouchScrewHole() {
    bltouchScrewHoleRadius = 3.2 / 2;
    translate([0, 0, -1]) {
        cylinder(h=motorAngleBracketThickness + 2, r= bltouchScrewHoleRadius, $fn = 30);
    }
    
}

module lowerGantryMount() {
    
    lowerGantryHeight = 7;
    lowerGantryHeightToBracket = lowerGantryHeight + motorAngleBracketThickness;
    translate([-motorAngleBracketDepth, 0, -lowerGantryHeightToBracket]) {
        difference() {
            cube([topGantryMountWidth, gantryMountThickness, lowerGantryHeightToBracket]);
            lowerGantryMountScrewHoles();
        }
    } 
}

module topGantryMount() {
    fullMountHeight = motorAngleBracketThickness + topGantryMountHeight;
    translate([-motorAngleBracketDepth, 0, motorMountHeight - motorAngleBracketThickness]) {
        difference() {
            cube([topGantryMountWidth, gantryMountThickness, fullMountHeight]);
            topGantryMountScrewHoles(topGantryMountWidth);
        }
    }
    
}

module centerGantryMount() {
    translate([-motorAngleBracketDepth, 0, 0]) {
        cube([topGantryMountWidth, gantryMountThickness, motorMountHeight - motorAngleBracketThickness]);
    }
}

module lowerGantryMountScrewHoles() {
    // Distance for the bottom mount's screw hole from the bottom of the bracket
    originalModelScrewHoleDistanceBottom = 2.6;

    screwDistanceFromBottomEdge = originalModelScrewHoleDistanceBottom + (originalModelScrewHole / 2);

originalModelDistanceBetweenRightmostScrews = 19.8;
    distanceBetweenRightmostScrews = originalModelDistanceBetweenRightmostScrews + originalModelScrewHole;

    originalModelDistanceFromRightEdge = 1.9;

    outerRightScrewHoleDistanceFromLeftEdge = lowerGantryWidth - originalModelDistanceFromRightEdge;

    translate([leftScrewDistanceFromLeftEdge(), 0, screwDistanceFromBottomEdge]) {
        gantryScrewHole();
    }

    translate([rightScrewHoleDistanceFromLeftEdge(), 0, screwDistanceFromBottomEdge]) {
        gantryScrewHole();
    }
    
}

module topGantryMountScrewHoles(topGantryMountWidth) {
    originalModelScrewHoleDistanceFromTopBracket = 1.9;
    screwHoleDistanceBottom = motorAngleBracketThickness + originalModelScrewHoleDistanceFromTopBracket + (originalModelScrewHole / 2);
    // Distance between the edges of the far right screw and the center screw, from the original model.
    originalModelDistanceBetweenRightmostScrews = 19.8;
    distanceBetweenRightmostScrews = originalModelDistanceBetweenRightmostScrews + originalModelScrewHole;

    originalModelDistanceFromRightEdge = 1.9;

    outerRightScrewHoleDistanceFromLeftEdge = topGantryMountWidth - originalModelDistanceFromRightEdge - (originalModelScrewHole / 2);

    translate([leftScrewDistanceFromLeftEdge(), 0, screwHoleDistanceBottom]) {
        gantryScrewHole();
    }
    translate([rightScrewHoleDistanceFromLeftEdge(), 0, screwHoleDistanceBottom]) {
        gantryScrewHole();
    }
    translate([outerRightScrewHoleDistanceFromLeftEdge, 0, screwHoleDistanceBottom]) {
        gantryScrewHole();
    }
}

module gantryScrewHole() {
    rotate([-90, 0, 0]) {
        m3ScrewHole(gantryMountThickness);
    }
}

module m3ScrewHole(depth) {
    m3ClearanceDiameter = 3.4;
    radius = m3ClearanceDiameter / 2;
    translate([0, 0, -1]) {
        cylinder(depth + 2, radius, radius, $fs = 0.2);
    }
    
}

function leftScrewDistanceFromLeftEdge() = originalModelScrewHoleDistanceLeftEdge + (originalModelScrewHole / 2);
function rightScrewHoleDistanceFromLeftEdge() = leftScrewDistanceFromLeftEdge() + originalModelScrewHoleDistance + originalModelScrewHole;