include <front_plug_common.scad>


cornerDia=10;

wireDia=9;
// This should be approximately trianglePatchWidth* 2/3
wireHoleXOffset=50;
wireHoleYOffset=82;
wireHoleRotationAngle=-70;
wireHoleReliefAngle=25;
wireHoleExtraCutLengthForReliefAngle=10;

overhangMaxDepth=25;


// x-offset from the inner edge of the boat side-rail to the corner above the rod-holders
trianglePatchWidth=75;

// y-offset from the base corner / trailing edge of motor mount.
trianglePatchApexYPosition=85;

// measured from the outer edge of the boat (approximately same as bottom of motormount V)
trianglePatchHighSideZOffset=22.5;
trianglePatchLowSideZOffset=10.5;


// calculated
trianglePatchLowToHighRise=trianglePatchHighSideZOffset-trianglePatchLowSideZOffset;

overlap=0.001;
surfaceThickness=0.01;

// Top view is from above the motor mount looking towards the back of the boat
// origin is at the back edge of the motor mount (x axis)
//       and at the "V" in the lower motor mount plate 
//       (which is also approximately the same position as the outer edge of the boat's side rail)

// NOTE: Some angles appear sharper because the top plate of the motor mount is
// angled up on the boat, but modeled level/flat.  Trust the measurements.

hull() {
    // top ridge adjacent to the trailing edge of the motor mount
    translate([-motorMountPlateVOffset+cornerDia/2,0,overhangMaxDepth]) 
        cube([motorMountPlateWidth-cornerDia/2, surfaceThickness, surfaceThickness]);
    translate([-motorMountPlateVOffset+cornerDia/2,cornerDia/2,overhangMaxDepth]) 
        cylinder(d=cornerDia, h=surfaceThickness);
    
    // bottom of V adjacent to the trailing edge of the motor mount
    cube([surfaceThickness,surfaceThickness,surfaceThickness]);
    
    // rear bend aligned with motor mount "V"
    translate([0,transitionWidthAtV-cornerDia/2,overhangMaxDepth])
        cylinder(d=cornerDia, h=surfaceThickness);
    
    // top plate at inner edge of boat side-rail (trailing end of bracket)
    translate([motorMountPlateVOffsetShortSide-cornerDia/2,transitionWidthAtV-cornerDia/2,overhangMaxDepth]) 
        cylinder(d=cornerDia, h=surfaceThickness);
}

translate([motorMountPlateVOffsetShortSide,0,overhangMaxDepth-overlap])
difference() {
    hull() {
       translate([trianglePatchWidth-cornerDia/2,trianglePatchApexYPosition,trianglePatchLowToHighRise]) 
           cylinder(d=cornerDia, h=surfaceThickness);
       translate([0,0,0])
           cube([surfaceThickness,transitionWidthAtV,trianglePatchLowToHighRise]);
    }
    // hole for wires
    translate([wireHoleXOffset,wireHoleYOffset,0])
    rotate([wireHoleReliefAngle,0,wireHoleRotationAngle])
    hull() {
        cylinder(d=wireDia, 
            h=trianglePatchLowToHighRise+surfaceThickness+overlap*2+wireHoleExtraCutLengthForReliefAngle);
        translate([wireDia,0,0])
            cylinder(d=wireDia, 
                h=trianglePatchLowToHighRise+surfaceThickness+overlap*2+wireHoleExtraCutLengthForReliefAngle);
    }
}