include <front_plug_common.scad>
include <battery_box_plug_common.scad>

receptacleBracketLength=80;
receptacleBracketCornerDia=8;
mountingPlateThickness=25;
circuitBreakerBaseHeight=74;
circuitBreakerBaseWidth=48.5;
circuitBreakerMountHoleInsetSide=11;
circuitBreakerMountHoleInsetEnd=8.5;
circuitBreakerMountHoleDia=6.75;
circuitBreakerMountPlateCornerDia=5;

circuitBreakerScrewHoleDepth=12;
circuitBreakerScrewHoleDia=circuitBreakerMountHoleDia-2;  // 1mm thread depth

$fn=50;
overlap=0.001;

union() {
    difference() {
            hull() {
                translate([receptacleSideWidth/2-receptacleBracketCornerDia/2,
                        receptacleSideWidth/2-receptacleBracketCornerDia/2,0])
                    cylinder(d=receptacleBracketCornerDia,h=receptacleBracketLength);
                
                translate([receptacleSideWidth/2-receptacleBracketCornerDia,
                        -receptacleSideWidth/2,0])
                    cube([receptacleBracketCornerDia,receptacleBracketCornerDia,receptacleBracketLength]);
                
                translate([-receptacleSideWidth/2+receptacleBracketCornerDia/2,
                        receptacleSideWidth/2-receptacleBracketCornerDia/2,0])
                    cylinder(d=receptacleBracketCornerDia,h=receptacleBracketLength);
                
                translate([-receptacleSideWidth/2,
                        -receptacleSideWidth/2,0])
                    cube([receptacleBracketCornerDia,receptacleBracketCornerDia,receptacleBracketLength]);
            }
        translate([0,0,mountingPlateThickness])
            cylinder(d=receptacleMountingRingInsetDia, h=receptacleBracketLength-mountingPlateThickness+overlap*2);
        translate([0,0,-overlap])
            cylinder(d=receptacleInnerDia, h=receptacleBracketLength+overlap*2);
    }
    
    translate([receptacleSideWidth/2,0,0])
        rotate([90,0,90])
            circuitBreakerMountPlate();
}

module circuitBreakerMountPlate() {
    translate([0,circuitBreakerBaseHeight/2+circuitBreakerMountPlateCornerDia/2,0])
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