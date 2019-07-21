# Entry Point

Parts are rendered via the entry.scad entry point.  Any complete models must be parameterized and moved into the lib folder.  maind.scad is only for rendering STL files and should be left blank in the repository (.gitignore);

# Instructions:

1. Create a file named entry.scad
1. Open with OpenSCAD
1. Import required  "z" lib.
1. Use top-most module in imported lib via entry.scad.

# Coding Standards

* All files committed must build without error.
* camelCasing naming convention
* spaces after commas ie: [a, b] and testFunction(a, b)

# License

All OpenSCAD code is licensed GNU GPL-V3.  The license is included in this repository as GPL.txt