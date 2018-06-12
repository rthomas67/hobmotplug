include <front_plug_common.scad>

surfaceThickness=0.01;
// Block that goes behind the receptacle bracket and over the top
// cord and triangle patch

frontInsertionDepth=5;
frontInsertionRimWidth=5;
frontInsertionTolerance=0.5;

frontPlateToMotorMountEdgeWidth=25;

overlap=0.001;
$fn=50;

// the plate will be mounted centered
// the corner of the lower transition plate will align with the V underneath
transitionCornerXoffset=-motorMountPlateWidth/2-motorMountPlateVOffsetShortSide;

difference() {
    union() {
        // matching plate for back of receptacle bracket.
        %hull() {
            // left base corner
            translate([-receptacleBracketBaseWidth/2+receptacleBracketBaseCornerRadius,
                    receptacleBracketBaseCornerRadius,0]) 
                cylinder(r=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            // right base corner
            translate([receptacleBracketBaseWidth/2-receptacleBracketBaseCornerRadius,
                    receptacleBracketBaseCornerRadius,0]) 
                cylinder(r=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            translate([0,receptacleOuterDia/2,0]) 
                cylinder(d=receptacleOuterDia, h=surfaceThickness);
            // right edge/corner of motor mount plate
            translate([motorMountPlateWidth/2,receptacleBracketBaseCornerRadius/2,
                    frontPlateToMotorMountEdgeWidth])
                cylinder(d=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            // left edge/corner of motor mount plate
            translate([-motorMountPlateWidth/2,receptacleBracketBaseCornerRadius/2,
                    frontPlateToMotorMountEdgeWidth])
                cylinder(d=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            // rear corner of transition cover aligned with the "V"
            translate([-motorMountPlateVOffsetShortSide,receptacleBracketBaseCornerRadius/2,
                frontPlateToMotorMountEdgeWidth+transitionWidthAtV])
                    rotate([0,-45,0])
                    cylinder(d=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            // rear corner of transition cover at the edge of the boat
            translate([-motorMountPlateWidth/2,receptacleBracketBaseCornerRadius/2,
                frontPlateToMotorMountEdgeWidth+transitionWidthAtV])
                    rotate([0,-90,0])
                    cylinder(d=receptacleBracketBaseCornerRadius, h=surfaceThickness);
            }
        
        // part that inserts a little into the back of the receptacle bracket
        // to align.
        translate([0,receptacleOuterDia/2,-frontInsertionDepth]) 
            cylinder(d=receptacleMountingRingInsetDia-frontInsertionTolerance*2,
                h=frontInsertionDepth+overlap);
        
        // Wire tunnel over the top of the boat
            translate([-motorMountPlateWidth/2,0,0])
        rotate([0,0,-12])
        rotate([-90,0,0])
        translate([-50,0,0])
        hull() {
            translate([])
                cylinder(d=20, h=20);
        }    
    }
    // Wire thru-hole from insertion plate through front of insertion cylinder
    translate([0,receptacleOuterDia/2,-frontInsertionDepth-overlap]) 
        cylinder(d=receptacleMountingRingInsetDia-frontInsertionRimWidth*2, 
            h=frontInsertionDepth+overlap*2+surfaceThickness);
}

