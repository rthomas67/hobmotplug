include <front_plug_common.scad>
include <battery_box_plug_common.scad>

wireGuideExitHeight=20;
wireGuideCornerDia=8;
wireGuideThickness=80;
cylinderCutoutDepth=20;
alignmentRingThickness=10;
alignmentRingTolerance=1;

circuitBreakerBaseHeight=74;
circuitBreakerBaseWidth=48.5;
circuitBreakerMountHoleInsetSide=11;
circuitBreakerMountHoleInsetEnd=8.5;
circuitBreakerMountHoleDia=6.75;
circuitBreakerMountPlateCornerDia=5;

circuitBreakerScrewHoleDepth=12;
circuitBreakerScrewHoleDia=circuitBreakerMountHoleDia-2;  // 1mm thread depth

// Adjustments
circuitBreakerMountYOffset=40;
circuitBreakerMountAngle=51; // TODO: calculate this

wireThruHoleLength=90;
wireThruHoleYPosition=15;

wireHoleToCircuitBreakerLength=130;
wireHoleToCircuitBreakerYPosition=5;
wireHoleToCircuitBreakerZPosition=125;
wireHoleToCircuitBreakerXPosition=60;
wireHoleToCircuitBreakerZAngle=35;
wireHoleToCircuitBreakerXAngle=-55;

wireHoleFromCircuitBreakerLength=130;
wireHoleFromCircuitBreakerYPosition=-25;
wireHoleFromCircuitBreakerZPosition=70;
wireHoleFromCircuitBreakerXPosition=-60;
wireHoleFromCircuitBreakerZAngle=-25;
wireHoleFromCircuitBreakerXAngle=-20;

overlap=0.001;
$fn=50;

difference() {
    union() {
        cover();
        translate([0, wireGuideThickness-alignmentRingThickness/2,
                receptacleSideWidth/2])
            rotate([-90,0,0])
                alignmentRing();
        translate([0,circuitBreakerMountYOffset,receptacleSideWidth*2/3])
            rotate([0,-circuitBreakerMountAngle,90])
                circuitBreakerMountPlate();
    }
    translate([0, wireGuideThickness-cylinderCutoutDepth+overlap,
            receptacleSideWidth/2])
        rotate([-90,0,0])
            cutout();
    translate([0,wireThruHoleYPosition,-wireThruHoleDia])
        rotate([-35,0,0])
            wireThruHole();
    translate([wireHoleToCircuitBreakerXPosition,wireHoleToCircuitBreakerYPosition,wireHoleToCircuitBreakerZPosition])
        rotate([wireHoleToCircuitBreakerXAngle-90,0,wireHoleToCircuitBreakerZAngle])
            wireHoleToCircuitBreaker();
    translate([wireHoleFromCircuitBreakerXPosition,
            wireHoleFromCircuitBreakerYPosition,wireHoleFromCircuitBreakerZPosition])
        rotate([wireHoleFromCircuitBreakerXAngle-90,0,wireHoleFromCircuitBreakerZAngle])
            wireHoleFromCircuitBreaker();
}

module cover() {
    hull() {
        translate([receptacleSideWidth/2-wireGuideCornerDia/2,wireGuideCornerDia/2,0])
            cylinder(d=wireGuideCornerDia, h=wireGuideExitHeight);
        translate([-receptacleSideWidth/2+wireGuideCornerDia/2,wireGuideCornerDia/2,0])
            cylinder(d=wireGuideCornerDia, h=wireGuideExitHeight);
        
        // bottom corners on insert face
        translate([-receptacleSideWidth/2,
                wireGuideThickness-wireGuideCornerDia/2-wireGuideCornerDia,0])
            cube([wireGuideCornerDia,wireGuideCornerDia,wireGuideCornerDia]);
        translate([receptacleSideWidth/2-wireGuideCornerDia,
                wireGuideThickness-wireGuideCornerDia/2-wireGuideCornerDia,0])
            cube([wireGuideCornerDia,wireGuideCornerDia,wireGuideCornerDia]);
        // top corners on insert face
        translate([-receptacleSideWidth/2+wireGuideCornerDia/2,
                wireGuideThickness-wireGuideCornerDia/2-wireGuideCornerDia,receptacleSideWidth])
            rotate([-90,0,0]) cylinder(d=wireGuideCornerDia, h=wireGuideCornerDia);
        translate([receptacleSideWidth/2-wireGuideCornerDia/2,
                wireGuideThickness-wireGuideCornerDia/2-wireGuideCornerDia,receptacleSideWidth])
            rotate([-90,0,0]) cylinder(d=wireGuideCornerDia, h=wireGuideCornerDia);
        
    }    
}

module alignmentRing() {
    difference() {
        cylinder(d=receptacleMountingRingInsetDia-alignmentRingTolerance, h=alignmentRingThickness);
        translate([0,0,-overlap])
            cylinder(d=receptacleInnerDia, h=alignmentRingThickness+overlap*2);
    }
}

module cutout() {
    cylinder(d=receptacleInnerDia, h=cylinderCutoutDepth);
}

/*
 * Intersects a radial sweep (torus) with a cylinder to make a curved pipe
 */
module wireHoleToCircuitBreaker() {
    bendIntersectionDia=90;
    //cylinder(d=wireThruHoleDia, h=wireHoleToCircuitBreakerLength);
    rotate([0,0,90])
    translate([-bendIntersectionDia/2,0,wireHoleToCircuitBreakerLength/2])
    rotate([90,0,0])
    intersection() {
        rotate_extrude()
            translate([bendIntersectionDia/2, 0, 0])
                circle(d=wireThruHoleDia);
        rotate([0,0,30])
            translate([bendIntersectionDia/4,0,-wireThruHoleDia/2-overlap])
                cylinder(d=bendIntersectionDia, h=wireThruHoleDia+overlap*2, $fn=5);
    }
}

module wireHoleFromCircuitBreaker() {
    bendIntersectionDia=120;
    //cylinder(d=wireThruHoleDia, h=wireHoleToCircuitBreakerLength);
    rotate([0,0,90])
    translate([-bendIntersectionDia/2,0,wireHoleToCircuitBreakerLength/2])
    rotate([90,0,0])
    intersection() {
        rotate_extrude()
            translate([bendIntersectionDia/2, 0, 0])
                circle(d=wireThruHoleDia);
        rotate([0,0,30])
            translate([bendIntersectionDia/4,0,-wireThruHoleDia/2-overlap])
                cylinder(d=bendIntersectionDia, h=wireThruHoleDia+overlap*2, $fn=5);
    }
}

module wireThruHole() {
        hull() {
            translate([wireThruHoleDia*3/4,0,0])
                cylinder(d=wireThruHoleDia, h=wireThruHoleLength);
            translate([-wireThruHoleDia*3/4,0,0])
                cylinder(d=wireThruHoleDia, h=wireThruHoleLength);
        }
}

module circuitBreakerMountPlate() {
        rotate([0,0,90])
        difference() {
            minkowski() {
                translate([-circuitBreakerBaseWidth/2,-circuitBreakerBaseHeight/2,0])
                cube([circuitBreakerBaseWidth,circuitBreakerBaseHeight,
                    circuitBreakerScrewHoleDepth-overlap*2]);
                cylinder(d=circuitBreakerMountPlateCornerDia,h=overlap);
            }
            translate([-circuitBreakerBaseWidth/2+circuitBreakerMountHoleInsetSide, 
                    circuitBreakerBaseHeight/2-circuitBreakerMountHoleInsetEnd,-overlap])
                cylinder(d=circuitBreakerScrewHoleDia, h=circuitBreakerScrewHoleDepth+overlap*2);
            translate([circuitBreakerBaseWidth/2-circuitBreakerMountHoleInsetSide,
                    -circuitBreakerBaseHeight/2+circuitBreakerMountHoleInsetEnd,-overlap])
                cylinder(d=circuitBreakerScrewHoleDia, h=circuitBreakerScrewHoleDepth+overlap*2);
        }
}

// Trial Print 1 Notes
// Hole to circuit breaker needs to be large enough for the terminal ring to pass through.
// Face is taller than the other part by about 3mm
// Transition from bottom of cutout to bottom of wireThruHole could be smooth
//     by cutting across it (semi-cylinder)
// Add mounting holes for screws to go into the bottom face

