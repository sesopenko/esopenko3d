use <z_gridPlate.scad>

legHeight = 25;
legWidth = 15;
meshThickness = 3;

module z_plantStand(width, height) {
    union() {
        translate([0, 0, -(meshThickness / 2)]) {
            z_gridPlate(gridX = width, gridY = height, meshSpace = 4, meshSolid = 2, thickness = meshThickness);
        }
        
        // add legs
        translate([0, 0, -legHeight]) {
            translate([-legWidth / 2, -legWidth / 2, 0]) {
                leg();
            }
            translate([width / 2 - legWidth, height / 2 - legWidth, 0]) {
                leg();
            }
            translate([-(width / 2), height / 2 - legWidth, 0]) {
                leg();
            }
            translate([-(width / 2), -(height / 2), 0]) {
                leg();
            }
            translate([(width / 2) - legWidth, -(height / 2), 0]) {
                leg();
            }
            translate([(width / 2) - legWidth, -legWidth / 2, 0]) {
                leg();
            }
            translate([-(width / 2), -legWidth / 2, 0]) {
                leg();
            }
            translate([-legWidth / 2, -height / 2, 0]) {
                leg();
            }
            translate([-legWidth / 2, height / 2 - legWidth, 0]) {
                leg();
            }
            
        }
    }
}

module leg() {
    cube([legWidth, legWidth, legHeight]);
}