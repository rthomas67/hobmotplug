include <front_plug_common.scad>
include <battery_box_plug_common.scad>

receptacleBracketLength=80;
mountingPlateThickness=20;

wireThruHoleToCircuitBreakerLength=40;
wireThruHoleToCircuitBreakerInset=5;
wireThruHoleToCircuitBreakerCenterOffset=15;

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
    
}

// Trial Print 1 Notes
// Add mounting holes for screws to go into the bottom face
// Face is shorter than the other part by about 3mm
// receptacleMountingRingInsetDia is about 2mm too small (maybe forgot to add a tolerance var??)
// receptacleInnerDia is about 2mm too small (tolerance again??)
// Front Face prints against bed.  Corners are sloppy/shrunken.  Maybe curve them.
// Assembly: Unless the wires can be pushed through the other part as the parts are
//      moved together, assembly will be difficult/impossible because there isn't
//      room for excess wire.
