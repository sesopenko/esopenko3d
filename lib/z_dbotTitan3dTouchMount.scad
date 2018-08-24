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

module z_dbotTitan3dTouchMount() {
    union() {
        motorMount();
        gantryMounts();
    }
    
    
}

module gantryMounts() {
    lowerGantryMount();
    topGantryMount();
    motorGantryMount();
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
            motorMountBracket();
        }
        translate([0, 0, -gantryMountThickness]) {
            cube([motorMountThickness, motorWidth, gantryMountThickness]);
        }
        translate([0, 0, motorMountHeight - motorAngleBracketThickness]) {
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
            cylinder(depth, radius, radius, $fs = 0.2);
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

module lowerGantryMount() {
    lowerGantryWidth = 24.8;
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
    
    mountWidth = 43;
    mountHeight = 7;
    fullMountHeight = motorAngleBracketThickness + mountHeight;
    translate([-motorAngleBracketDepth, motorWidth, motorMountHeight - motorAngleBracketThickness]) {
        difference() {
            cube([mountWidth, gantryMountThickness, fullMountHeight]);
            topGantryMountScrewHoles(mountWidth);
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

module topGantryMountScrewHoles(mountWidth) {
    originalModelScrewHoleDistanceFromTopBracket = 1.9;
    screwHoleDistanceBottom = motorAngleBracketThickness + originalModelScrewHoleDistanceFromTopBracket + (originalModelScrewHole / 2);
    // Distance between the edges of the far right screw and the center screw, from the original model.
    originalModelDistanceBetweenRightmostScrews = 19.8;
    distanceBetweenRightmostScrews = originalModelDistanceBetweenRightmostScrews + originalModelScrewHole;

    originalModelDistanceFromRightEdge = 1.9;

    outerRightScrewHoleDistanceFromLeftEdge = mountWidth - originalModelDistanceFromRightEdge - (originalModelScrewHole / 2);

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
    cylinder(depth, radius, radius, $fs = 0.2);
}

function leftScrewDistanceFromLeftEdge() = originalModelScrewHoleDistanceLeftEdge + (originalModelScrewHole / 2);
function rightScrewHoleDistanceFromLeftEdge() = leftScrewDistanceFromLeftEdge() + originalModelScrewHoleDistance + originalModelScrewHole;