renderHood=true;
renderBottomPlate=!renderHood;

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

baseAngle=20;
hoodAngle=50;

hoodDepth=45; // mm out on the top side.
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

attachmentLegWidth=24;
attachmentLegLength=40;
attachmentLegThickness=20;
attachmentCornerRoundnessDia=3;
attachmentEndTaperInset=6;
screwHoleDia=4;
attachmentLegSeparation=60;

bezelFaceWidthCenter=bezelFaceWidth/2;

bottomPlateThickness=10;
bottomPlateCornerRoundnessDia=3;
bottomPlateScrewHoleDia=3.5;
bottomPlateScrewHoleInset=bezelFaceSideWidth/2;
bottomPlateLength=bezelFaceHeight/cos(baseAngle);

if (renderHood) hood();
if (renderBottomPlate) bottomPlate();

module hood() {



    difference() {
        union() {
            rotate([baseAngle,0,0]) translate([0,0,-baseExtraDepthForAngle]) {
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
            // left attachment leg
            translate([-attachmentLegWidth/2+bezelFaceWidthCenter-attachmentLegSeparation/2,
                    bezelFaceHeight-hoodThickness,0])
                attachmentLeg(attachmentLegWidth,attachmentLegLength,
                attachmentLegThickness,attachmentCornerRoundnessDia,
                attachmentEndTaperInset,screwHoleDia);

            // right attachment leg
            translate([attachmentLegWidth/2+bezelFaceWidthCenter+attachmentLegSeparation/2,
                    bezelFaceHeight-hoodThickness,0])
                attachmentLeg(attachmentLegWidth,attachmentLegLength,
                attachmentLegThickness,attachmentCornerRoundnessDia,
                attachmentEndTaperInset,screwHoleDia);
        }
        translate([-overlap,-overlap,-baseExtraDepthForAngle])
            cube([bezelFaceWidth+overlap*2,bottomCutHeight+overlap*2,baseExtraDepthForAngle]);
                    // bottom plate mount screw holes
        translate([bezelFaceWidth-bottomPlateScrewHoleInset,
                bottomPlateScrewHoleInset,
                -overlap]) {
            cylinder(h=bottomPlateScrewHoleDia*2/3, h=bottomPlateThickness);
        }
        translate([bottomPlateScrewHoleInset,bottomPlateScrewHoleInset,
                -overlap]) {
            cylinder(h=bottomPlateScrewHoleDia*2/3, h=bottomPlateThickness);
        }
        translate([bottomPlateScrewHoleInset,
                bottomPlateLength-bottomPlateScrewHoleInset,
                -overlap]) {
            cylinder(h=bottomPlateScrewHoleDia*2/3, h=bottomPlateThickness);
        }
        translate([bezelFaceWidth-bottomPlateScrewHoleInset,
                bottomPlateLength-bottomPlateScrewHoleInset,
                -overlap]) {
            cylinder(h=bottomPlateScrewHoleDia*2/3, h=bottomPlateThickness);
        }

    }
}

module bottomPlate() {
    translate([0,0,overlap])
        difference() {
            bottomPlateWithoutHoles(bottomPlateThickness, bezelFaceWidth, 
                bottomPlateLength, bottomPlateCornerRoundnessDia);
            translate([bezelFaceWidth-bottomPlateScrewHoleInset,
                    bottomPlateScrewHoleInset,0]) {
                countersunkScrewHole(bottomPlateScrewHoleDia, bottomPlateThickness);
            }
            translate([bottomPlateScrewHoleInset,bottomPlateScrewHoleInset,0]) {
                countersunkScrewHole(bottomPlateScrewHoleDia, bottomPlateThickness);
            }
            translate([bottomPlateScrewHoleInset,
                    bottomPlateLength-bottomPlateScrewHoleInset,0]) {
                countersunkScrewHole(bottomPlateScrewHoleDia, bottomPlateThickness);
            }
            translate([bezelFaceWidth-bottomPlateScrewHoleInset,
                    bottomPlateLength-bottomPlateScrewHoleInset,0]) {
                countersunkScrewHole(bottomPlateScrewHoleDia, bottomPlateThickness);
            }

        }
}
    
module bottomPlateWithoutHoles(pBottomPlateThickness, pPlateWidth, 
        pPlateLength, pCornerRoundness) {
    hull() {
        cube([pPlateWidth,pPlateLength,overlap]);
        // top corner at origin
        translate([pCornerRoundness/2,pCornerRoundness/2,
                pBottomPlateThickness-bottomPlateCornerRoundnessDia/2])
            sphere(d=pCornerRoundness);
        // top corner at +x
        translate([pPlateWidth-pCornerRoundness/2,pCornerRoundness/2,
                pBottomPlateThickness-pCornerRoundness/2])
            sphere(d=pCornerRoundness);
        // top corner at +y
        translate([pCornerRoundness/2,
                pPlateLength-pCornerRoundness/2,
                pBottomPlateThickness-pCornerRoundness/2])
            sphere(d=pCornerRoundness);
        // top corner at +x,+1
        translate([pPlateWidth-pCornerRoundness/2,
                pPlateLength-pCornerRoundness/2,
                pBottomPlateThickness-pCornerRoundness/2])
            sphere(d=pCornerRoundness);
    }

}

module attachmentLeg(pAttachmentLegWidth,pAttachmentLegLength,
        pAttachmentLegThickness,pAttachmentCornerRoundnessDia,
        pAttachmentEndTaperInset,pScrewHoleDia) {
    difference() {
        hull() {
            // end bottom corner right
            translate([pAttachmentLegWidth/2-pAttachmentCornerRoundnessDia/2,
                    pAttachmentLegLength-pAttachmentCornerRoundnessDia/2,0])
                cylinder(d=pAttachmentCornerRoundnessDia, h=overlap);
            // end bottom corner left
            translate([-pAttachmentLegWidth/2+pAttachmentCornerRoundnessDia/2,
                    pAttachmentLegLength-pAttachmentCornerRoundnessDia/2,0])
                cylinder(d=pAttachmentCornerRoundnessDia, h=overlap);
            // end top corner right
            translate([pAttachmentLegWidth/2-pAttachmentCornerRoundnessDia/2,
                    pAttachmentLegLength-pAttachmentCornerRoundnessDia/2-pAttachmentEndTaperInset,
                    pAttachmentLegThickness-pAttachmentCornerRoundnessDia/2
                        -pAttachmentEndTaperInset])
                sphere(d=pAttachmentCornerRoundnessDia);
            // end top corner left
            translate([-pAttachmentLegWidth/2+pAttachmentCornerRoundnessDia/2,
                    pAttachmentLegLength-pAttachmentCornerRoundnessDia/2-pAttachmentEndTaperInset,
                    pAttachmentLegThickness-pAttachmentCornerRoundnessDia/2
                        -pAttachmentEndTaperInset])
                sphere(d=pAttachmentCornerRoundnessDia);
            // base bottom corner (full width box corner)
            translate([-pAttachmentLegWidth/2,0,0])
                cube([pAttachmentLegWidth,overlap,overlap]);
            // base top corner right
            translate([pAttachmentLegWidth/2-pAttachmentCornerRoundnessDia/2,0,
                    pAttachmentLegThickness-pAttachmentCornerRoundnessDia/2])
                rotate([-90,0,0])
                cylinder(d=pAttachmentCornerRoundnessDia, h=overlap);
            translate([-pAttachmentLegWidth/2+pAttachmentCornerRoundnessDia/2,0,
                    pAttachmentLegThickness-pAttachmentCornerRoundnessDia/2])
                rotate([-90,0,0])
                cylinder(d=pAttachmentCornerRoundnessDia, h=overlap);
        }
        // screw hole 1
        translate([0,pAttachmentLegLength/3,0]) {
            countersunkScrewHole(pScrewHoleDia, pAttachmentLegThickness);
        }
        // screw hole 2
        translate([0,pAttachmentLegLength*2/3,0]) {
            countersunkScrewHole(pScrewHoleDia, pAttachmentLegThickness);
        }
    }
}

module countersunkScrewHole(pScrewHoleDia, pMaterialThickness) {
    screwHoleInsetDia=pScrewHoleDia*2;
    translate([0,0,-overlap]) {
        cylinder(d=pScrewHoleDia, h=pMaterialThickness+overlap*2);
        translate([0,0,pMaterialThickness/2])
            cylinder(d=screwHoleInsetDia, h=pMaterialThickness);
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