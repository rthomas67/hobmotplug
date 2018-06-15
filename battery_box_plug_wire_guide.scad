include <battery_box_plug_common.scad>

wireGuideExitHeight=20;
wireGuideCornerDia=8;
wireGuideThickness=50;

hull() {
    translate([receptacleSideWidth/2-wireGuideCornerDia/2,wireGuideCornerDia/2,0])
        cylinder(d=wireGuideCornerDia, h=wireGuideExitHeight);
    translate([-receptacleSideWidth/2+wireGuideCornerDia/2,wireGuideCornerDia/2,0])
        cylinder(d=wireGuideCornerDia, h=wireGuideExitHeight);
    
    // change this to 4 short cylinders that extend directly from the bracket.
    translate([receptacleSideWidth/2-wireGuideCornerDia/2,
            wireGuideThickness-wireGuideCornerDia/2,0])
        cube([1,1,receptacleSideWidth]);
    translate([-receptacleSideWidth/2+wireGuideCornerDia/2,
            wireGuideThickness-wireGuideCornerDia/2,0])
        cube([1,1,receptacleSideWidth]);
}    