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
        motorMount();
        gantryMounts();
    }
    
}

module gantryMounts() {
    difference() {
        union() {
            lowerGantryMount();
            topGantryMount();
            motorGantryMount();
            cordHolder();
        }
        extruderGearOpening();
    }
    
    
    
}

module extruderGearOpening() {
    gearWidthAllowance = 9.2;
    gearWidthDistance = 9;
    translate([motorMountThickness, motorWidth + gantryMountThickness + 1, motorMountHeight]) {
        rotate([90, 0, ,0]) {
            linear_extrude(gantryMountThickness + 2) {
                polygon([
                    [0, -motorAngleBracketThickness - 1],
                    [0, 0],
                    [1.2, gearWidthDistance],
                    [1.2 + gearWidthAllowance, gearWidthDistance],
                    [1.2 + gearWidthAllowance + 3.7, 0],
                    [1.2 + gearWidthAllowance + 3.7, -motorAngleBracketThickness - 1],
                ]);
            }
        }
    }
}

module cordHolder() {
    translate([-motorAngleBracketDepth, motorWidth + gantryMountThickness, motorMountHeight + topGantryMountHeight]) {
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

module motorMount() {
    difference() {
        motorMountPositiveForm();
        motorMountSubtractions();
    }
}

module motorMountPositiveForm() {
    union() {
        cube([motorMountThickness, motorWidth, motorMountHeight]);
        translate([0, 0, -motorAngleBracketThickness]) {
            // Lower bracket
            lowerMotorMountBracket();
        }
        translate([0, 0, -gantryMountThickness]) {
            // Holds lower bracket to motor mount
            cube([motorMountThickness, motorWidth, gantryMountThickness]);
        }
        translate([0, 0, motorMountHeight - motorAngleBracketThickness]) {
            // upper angle bracket.
            motorMountBracket();
        }
    }
}

module motorMountSubtractions() {
     motorMountScrewHoles();
     motorMountMotorOpening(motorMountThickness);
}

module motorMountScrewHoles() {
    motorScrewDistance = 31;
    screwDistanceFromEdge = (motorWidth - motorScrewDistance) / 2;
    leftX = (motorWidth - motorScrewDistance) / 2;
    rightX = motorWidth - screwDistanceFromEdge;
    topY = -(motorWidth - screwDistanceFromEdge);
    bottomY = -(screwDistanceFromEdge);
    rotate([0, 90, 0]) {
        translate([topY, leftX, 0]) {
            m3ScrewHole(motorMountThickness);
        }
        translate([topY, rightX, 0]) {
            m3ScrewHole(motorMountThickness);
        }
        translate([bottomY, leftX, 0]) {
            m3ScrewHole(motorMountThickness);
        }
        translate([bottomY, rightX, 0]) {
            m3ScrewHole(motorMountThickness);
        }
    }
}

module motorMountMotorOpening(depth) {
    translate([0, motorWidth / 2, motorWidth / 2]) {
        rotate([0, 90, 0]) {
            opening = 23;
            radius = opening / 2;
            translate([0, 0, -1]) {
                cylinder(depth + 2, radius, radius, $fs = 0.2);
            }
            
        }
    }
}

module motorMountBracket() {
    bracketLength = motorWidth;
    translate([0, bracketLength, 0]) {
        rotate([0, 0, 180]) {
            linear_extrude(motorAngleBracketThickness) {
                polygon([
                    [0, 0],
                    [0, bracketLength],
                    [motorAngleBracketDepth, 0],
                ]);
            }
        }
    }   
}

module lowerMotorMountBracket() {
    // @see schematics/bltouch.pdf

    // measurements
    bltouchDepth = 11.5;
    bltouchScrewDistance = 18;
    bltouchScrewHoleRadius = 3.2 / 2;

    bltouchAllowance = 3;

    bltouchWidth = bltouchScrewDistance + ((bltouchScrewHoleRadius + 3) * 2);

    bracketLength = motorWidth + bltouchAllowance + bltouchDepth;

    bracketDepth = motorAngleBracketDepth;
    translate([-bracketDepth, -(bltouchAllowance + bltouchDepth), 0]) {
        union() {
            cube([bracketDepth,bracketLength,motorAngleBracketThickness]);
            translate([bracketDepth,0,0]) {
                // This is what the bltouch mounts to
                union() {
                    difference() {
                        cube([bltouchWidth, bltouchDepth + bltouchAllowance, motorAngleBracketThickness]);
                        union() {
                            translate([bltouchScrewHoleRadius + 3, bltouchDepth / 2, 0]) {
                                bltouchScrewHole();
                            }
                            translate([bltouchScrewHoleRadius + 3 + bltouchScrewDistance, bltouchDepth / 2, 0]) {
                                bltouchScrewHole();
                            }
                        }
                    }
                    translate([0, (bltouchDepth + bltouchAllowance) - motorAngleBracketThickness, 0]) {
                        difference() {
                            cube([bltouchWidth, motorAngleBracketThickness, 20]);
                            translate([motorAngleBracketThickness, 0, 0]) {
                                rotate([90, -90, -180]) {
                                    linear_extrude(motorAngleBracketThickness) {
                                        polygon([
                                            [20, 0],
                                            [20, bltouchWidth],
                                            [0, bltouchWidth]
                                            
                                        ]);
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
             
            }
        }
        // rotate([0, 0, 180]) {
        //     linear_extrude(motorAngleBracketThickness) {
        //         polygon([
        //             [0, 0],
        //             [0, bracketLength],
        //             [motorAngleBracketDepth, 0],
        //         ]);
        //     }
        // }
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
    translate([-motorAngleBracketDepth, motorWidth, -lowerGantryHeightToBracket]) {
        difference() {
            cube([lowerGantryWidth, gantryMountThickness, lowerGantryHeightToBracket]);
            lowerGantryMountScrewHoles();
        }
    } 
}

module topGantryMount() {
    fullMountHeight = motorAngleBracketThickness + topGantryMountHeight;
    translate([-motorAngleBracketDepth, motorWidth, motorMountHeight - motorAngleBracketThickness]) {
        difference() {
            cube([topGantryMountWidth, gantryMountThickness, fullMountHeight]);
            topGantryMountScrewHoles(topGantryMountWidth);
        }
    }
    
}

module motorGantryMount() {
    translate([0, motorWidth, 0]) {
        cube([motorMountThickness, gantryMountThickness, motorMountHeight - motorAngleBracketThickness]);
    }
}

module lowerGantryMountScrewHoles() {
    // Distance for the bottom mount's screw hole from the bottom of the bracket
    originalModelScrewHoleDistanceBottom = 1.9;

    screwDistanceFromBottomEdge = originalModelScrewHoleDistanceBottom + (originalModelScrewHole / 2);

    //rightScrewHoleDistanceFromLeftEdge = leftScrewDistanceFromLeftEdge() + originalModelScrewHoleDistance + originalModelScrewHole;

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