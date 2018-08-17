module z_wallFilamentGuide() {
    wallMountWidth = 10;
    wallMountDepth = 10;
    wallMountThickness = 3;

    wallMountScrewHoleRadius = 1.5;

    union() {
        difference() {
            cube([wallMountWidth, wallMountDepth, wallMountThickness]);
            translate([wallMountWidth / 2, wallMountDepth / 2, 0]) {
                cylinder(wallMountThickness, wallMountScrewHoleRadius, wallMountScrewHoleRadius, $fs = 0.2);
            }
            
        }
    }
    
    
}