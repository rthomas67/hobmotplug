bezelInsertionWidth=85;
bezelInsertionHeight=45;
bezelInsertionDepth=23;

insertionTolerance=0.25;

bezelFaceWidth=105;
bezelFaceHeight=60;

clipDetentWidth=3; // depth of detent cutout
clipDetentHeight=11;
clipDetentInsetFromFace=0.75;

wireTunnelWidth=3;
wireTunnelHeight=21;
wireTunnelInsetFromRear=14;

baseAngle=30;
hoodAngle=30;

hoodDepth=30; // mm out on the top side.
hoodThickness=3;

// riser leaves room to maneuver the part in from the front
// and makes viewing easier.
hoodRiserDepth=bezelInsertionDepth;

rearClearance=8;

overlap=0.01;

// Calculated
bezelFaceSideWidth=(bezelFaceWidth-bezelInsertionWidth)/2;
bezelFaceTopHeight=(bezelFaceHeight-bezelInsertionHeight)/2;


baseExtraDepthForAngle=bezelFaceHeight*tan(baseAngle);
bottomCutHeight=bezelFaceHeight*2;

// full front-back dimension+ (room for screwdriver release)
clipDetentDepth=bezelInsertionDepth+rearClearance+baseExtraDepthForAngle;

attachmentTabWidth=8;
$fn=50;


union() {

    // Note: approximate front/back center for tabs approximated
    // by _not_ subtracting the tab width.  Bottom is angle cut so it is longer
    // than the actual bezelFaceHeight.
    // left attachment tab
    translate([overlap,bezelFaceHeight/2,0])
        mirror([1,0,0]) attachmentTab(attachmentTabWidth);

    // right attachment tab
    translate([bezelFaceWidth-overlap,bezelFaceHeight/2,0])
        attachmentTab(attachmentTabWidth);


    difference() {
        rotate([baseAngle,0,0])
            translate([0,0,-baseExtraDepthForAngle]) {
                union() {
                    // base
                    difference() {
                        cube([bezelFaceWidth,bezelFaceHeight,bezelInsertionDepth+rearClearance
                            +baseExtraDepthForAngle]);
                        // insertion cutout
                        translate([bezelFaceSideWidth-insertionTolerance,
                                bezelFaceTopHeight-insertionTolerance,-overlap])
                            cube([bezelInsertionWidth+insertionTolerance*2,
                                    bezelInsertionHeight+insertionTolerance*2,
                                bezelInsertionDepth+rearClearance
                                +baseExtraDepthForAngle+overlap*2]);
                        // wire tunnel
                        translate([bezelFaceSideWidth-wireTunnelWidth,
                                (bezelFaceHeight-wireTunnelHeight)/2,
                                -overlap])
                            cube([wireTunnelWidth+overlap,wireTunnelHeight,
                                wireTunnelInsetFromRear+rearClearance+baseExtraDepthForAngle
                                +overlap]);
                        // left detent
                        translate([bezelFaceSideWidth-clipDetentWidth,
                                (bezelFaceHeight-clipDetentHeight)/2,
                                bezelInsertionDepth+rearClearance+baseExtraDepthForAngle
                                    -clipDetentDepth-clipDetentInsetFromFace])
                            cube([clipDetentWidth+overlap,clipDetentHeight,
                                clipDetentDepth]);
                        // right detent
                        translate([bezelFaceWidth-bezelFaceSideWidth-overlap,
                                (bezelFaceHeight-clipDetentHeight)/2,
                                bezelInsertionDepth+rearClearance+baseExtraDepthForAngle
                                    -clipDetentDepth-clipDetentInsetFromFace])
                            cube([clipDetentWidth+overlap,clipDetentHeight,
                                clipDetentDepth]);
                        
                    }
                    // Riser for hood
                    translate([0,0,bezelInsertionDepth+rearClearance+baseExtraDepthForAngle])
                        difference() {
                            cube([bezelFaceWidth,bezelFaceHeight,hoodRiserDepth]);
                            translate([hoodThickness,-overlap,-overlap])
                                cube([bezelFaceWidth-hoodThickness*2,
                                    bezelFaceHeight-hoodThickness+overlap,
                                    hoodDepth+overlap*2]);
                        }
                    
                    // hood
                    translate([0,0,
                            bezelInsertionDepth+rearClearance+baseExtraDepthForAngle
                                +hoodRiserDepth])
                        difference() {
                            // move, rotate, move back
                            translate([0,bezelFaceHeight,0]) rotate([hoodAngle,0,0]) 
                                    translate([0,-bezelFaceHeight,0])
                                difference() {
                                    cube([bezelFaceWidth,bezelFaceHeight,hoodDepth]);
                                    translate([hoodThickness,-overlap,-overlap])
                                        cube([bezelFaceWidth-hoodThickness*2,
                                            bezelFaceHeight-hoodThickness+overlap,
                                            hoodDepth+overlap*2]);
                                }
                                // cut off front corner of hood
                                translate([-overlap,-bezelFaceHeight-overlap,-hoodDepth])
                                    cube([bezelFaceWidth+overlap*2,bezelFaceHeight,hoodDepth*2]);
                        }
                }
            }
        translate([-overlap,-overlap,-baseExtraDepthForAngle])
            cube([bezelFaceWidth+overlap*2,bottomCutHeight+overlap*2,baseExtraDepthForAngle]);
    }
}

module attachmentTab(attachmentTabWidth) {
    attachmentTabThickness=2.5;
    attachmentTabHoleDia=3;
    difference() {
        union() {
            translate([attachmentTabWidth,attachmentTabWidth/2,0])
                cylinder(d=attachmentTabWidth,h=attachmentTabThickness);
            cube([attachmentTabWidth,attachmentTabWidth,attachmentTabThickness]);
        }
        translate([attachmentTabWidth,attachmentTabWidth/2,-overlap])
            cylinder(d=attachmentTabHoleDia,h=attachmentTabThickness+overlap*2);
    }
}