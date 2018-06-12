include <front_plug_common.scad>

receptacleFaceplateWidth=77;
receptacleFaceplateHeight=57;
receptacleFaceplateThickness=5;
receptacleFaceplateScrewCenterWidth=64;
receptacleFaceplateScrewHoleDia=3.5;
receptacleFaceplateScrewDepth=8;
receptacleFaceplateCornerRadius=11;

motorMountHoleCenterWidth=76;
motorMountBoltShaftDia=7;
motorMountBoltHeadInsetDia=13.5;
// length from base of bolt head to motor mount plate.
motorMountBoltShaftThruLength=10;
motorMountBoltInsetFromFace=20;

receptacleMountingRingClearance=3;
mountingPlateThickness=25;

// perpendicular to the face, from front to back
receptacleBracketLength=80;

// (to center) Used to calculate the length of the screw tabs
mountingHoleInsetFromMotorMountBack=136.5;

// calculated
faceplateBottomOffset=receptacleOuterDia/2-receptacleFaceplateHeight/2;

screwTabLengthToHoleCenter=mountingHoleInsetFromMotorMountBack-receptacleBracketLength;

// common
surfaceThickness=0.01;
overlap=0.001;
$fn=50;

//color([1,0,0]) {
    translate([-receptacleFaceplateWidth/2+receptacleFaceplateCornerRadius,
        faceplateBottomOffset+receptacleFaceplateCornerRadius,
        -receptacleFaceplateThickness])
        %receptacle();
//}
union() {
    bracketBody();
    translate([motorMountHoleCenterWidth/2,0,0])
        rotate([-90,0,0]) screwTab();
    translate([-motorMountHoleCenterWidth/2,0,0])
        rotate([-90,0,0]) screwTab();
}

module bracketBody() {
    difference() {
        hull() {
            // left base corner
            translate([-receptacleBracketBaseWidth/2+receptacleBracketBaseCornerRadius,
                    receptacleBracketBaseCornerRadius,0]) 
                cylinder(r=receptacleBracketBaseCornerRadius, h=receptacleBracketLength);
            // right base corner
            translate([receptacleBracketBaseWidth/2-receptacleBracketBaseCornerRadius,
                    receptacleBracketBaseCornerRadius,0]) 
                cylinder(r=receptacleBracketBaseCornerRadius, h=receptacleBracketLength);
            translate([0,receptacleOuterDia/2,0]) 
                cylinder(d=receptacleOuterDia, h=receptacleBracketLength);
            translate([0,faceplateBottomOffset,0])
                hull() {  // faceplate
                    translate([-receptacleFaceplateWidth/2+receptacleFaceplateCornerRadius,
                            receptacleFaceplateHeight-receptacleFaceplateCornerRadius,0]) 
                        cylinder(r=receptacleFaceplateCornerRadius, h=mountingPlateThickness);
                    translate([receptacleFaceplateWidth/2-receptacleFaceplateCornerRadius,
                            receptacleFaceplateHeight-receptacleFaceplateCornerRadius,0]) 
                        cylinder(r=receptacleFaceplateCornerRadius, h=mountingPlateThickness);
                    
                    translate([-receptacleFaceplateWidth/2+receptacleFaceplateCornerRadius,
                            receptacleFaceplateCornerRadius,0]) 
                        cylinder(r=receptacleFaceplateCornerRadius, h=mountingPlateThickness);
                    translate([receptacleFaceplateWidth/2-receptacleFaceplateCornerRadius,
                            receptacleFaceplateCornerRadius,0]) 
                        cylinder(r=receptacleFaceplateCornerRadius, h=mountingPlateThickness);
                }
        }
        translate([0,receptacleOuterDia/2,-overlap]) 
            cylinder(d=receptacleInnerDia, h=receptacleBracketLength+overlap*2);
        translate([0,receptacleOuterDia/2,mountingPlateThickness]) 
            cylinder(d=receptacleMountingRingInsetDia+2*receptacleMountingRingClearance, 
                h=receptacleBracketLength-mountingPlateThickness+overlap);
        // Left Bolt thru-hole
//        translate([-motorMountHoleCenterWidth/2,-overlap,motorMountBoltInsetFromFace])
//            rotate([-90,0,0])
//                cylinder(d=motorMountBoltShaftDia, h=receptacleOuterDia+overlap*2);
        // Left head inset
//        translate([-motorMountHoleCenterWidth/2,
//                motorMountBoltShaftThruLength,motorMountBoltInsetFromFace])
//            rotate([-90,0,0])
//                cylinder(d=motorMountBoltHeadInsetDia, h=receptacleOuterDia+overlap*2);
        // Right Bolt thru-hole
//        translate([motorMountHoleCenterWidth/2,-overlap,motorMountBoltInsetFromFace])
//            rotate([-90,0,0])
//                cylinder(d=motorMountBoltShaftDia, h=receptacleOuterDia+overlap*2);
        // Right head inset
//        translate([motorMountHoleCenterWidth/2,
//                motorMountBoltShaftThruLength,motorMountBoltInsetFromFace])
//            rotate([-90,0,0])
//                cylinder(d=motorMountBoltHeadInsetDia, h=receptacleOuterDia+overlap*2);
        // Left faceplate screw hole
        translate([-receptacleFaceplateScrewCenterWidth/2,
                faceplateBottomOffset+receptacleFaceplateHeight/2,-overlap])
            rotate([0,0,0])
                cylinder(d=receptacleFaceplateScrewHoleDia, h=receptacleFaceplateScrewDepth);
        // Right faceplate screw hole
        translate([receptacleFaceplateScrewCenterWidth/2,
                faceplateBottomOffset+receptacleFaceplateHeight/2,-overlap])
            rotate([0,0,0])
                cylinder(d=receptacleFaceplateScrewHoleDia, h=receptacleFaceplateScrewDepth);
    }
}

module screwTab() {
    screwTabWidth=15;
    screwTabThickness=10;
    screwTabInsetDepth=3;
    difference() {
        hull() {
            translate([-screwTabWidth/2,0,0])
                cube([screwTabWidth,screwTabLengthToHoleCenter,screwTabThickness]);
            translate([0,screwTabLengthToHoleCenter,0])
                cylinder(d=screwTabWidth, h=screwTabThickness);
        }
        // bolt thru-hole
        translate([0,screwTabLengthToHoleCenter,-overlap])
            cylinder(d=motorMountBoltShaftDia, h=receptacleOuterDia+overlap*2);
        // bolt head inset
        translate([0,screwTabLengthToHoleCenter,screwTabThickness-screwTabInsetDepth])
            cylinder(d=motorMountBoltHeadInsetDia, h=receptacleOuterDia+overlap*2);
    }
}


module receptacle() {
    minkowski() {
        cube([receptacleFaceplateWidth-receptacleFaceplateCornerRadius*2,
            receptacleFaceplateHeight-receptacleFaceplateCornerRadius*2,
            receptacleFaceplateThickness-surfaceThickness]);
        cylinder(r=receptacleFaceplateCornerRadius, h=surfaceThickness);
    }
}