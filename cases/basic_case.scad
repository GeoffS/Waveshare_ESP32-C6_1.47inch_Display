include <../../OpenSCAD_Lib/MakeInclude.scad>
include <../../OpenSCAD_Lib/chamferedCylinders.scad>

firstLayerHeight = 0.2;
layerHeight = 0.2;

boardX = 20.32;
boardY = 36.37;

standoffCtsOffsetUsbEndX = 2.0;
standoffCtsOffsetUsbEndY = 2.4;

standoffCtsOffsetAntennaEndX = 3.52;
standoffCtsOffsetAntennaEndY = 1.97;

screwHoleDia = 2.5; // m2 clearance

extraXY = 4;
wallXY = 3;
wallZ = 4.2;
standoffZ = 2;

cornerDIaXY = 10;
exteriorCZ = 1;
exteriorZ = 9 + wallZ + standoffZ;

cornerCtrX = boardX/2 + extraXY - cornerDIaXY/2;
cornerCtrY = boardY/2 + extraXY - cornerDIaXY/2;

module itemModule()
{
    difference()
    {
        cornerOffsetY = -12 - cornerDIaXY/2;
        // Exterior:
        union()
        {
            hull() cornerXform(offsetY=cornerOffsetY) simpleChamferedCylinderDoubleEnded(d=cornerDIaXY, h=exteriorZ, cz=exteriorCZ);
            hull() cornerXform() simpleChamferedCylinderDoubleEnded(d=cornerDIaXY, h=wallZ, cz=exteriorCZ);
        }

        // interior:
        translate([0,0,wallZ]) hull() cornerXform(offsetY=cornerOffsetY) cylinder(d=cornerDIaXY-wallXY, h=100);

        screwHoled();

        // // USB-C cutout:
        // usbCutX = 13;
        // tcu([-usbCutX/2, 0, wallZ], [usbCutX, 100, 100]);

        // Button and USB cut:
        cutX = boardX + 2;
        tcu([-cutX/2, 0, wallZ], [cutX, 200, 200]);
    }

    // Standoffs:
    difference()
    {
        standoffsXform(z=wallZ-nothing) simpleChamferedCylinder(d=6, h=standoffZ, cz=4*layerHeight);
        screwHoled();
    }
}

module cornerXform(offsetY=0)
{
    doubleX() translate([cornerCtrX, -cornerCtrY, 0]) children();
    doubleX() translate([cornerCtrX, cornerCtrY+offsetY, 0]) children();
}

module standoffsXform(z)
{
    usbHoleCtrX = boardX/2 - standoffCtsOffsetUsbEndX;
    usbHoleCtrY = boardY/2 - standoffCtsOffsetUsbEndY;
    doubleX() translate([usbHoleCtrX, usbHoleCtrY, z]) children();

    antHoleCtrX = boardX/2 - standoffCtsOffsetAntennaEndX;
    antHoleCtrY = -boardY/2 + standoffCtsOffsetAntennaEndY;
    doubleX() translate([antHoleCtrX, antHoleCtrY, z]) children();
}

module screwHoled()
{
    standoffsXform(z=-10) cylinder(d=screwHoleDia, h=100);
}

module clip(d=0)
{
	// tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
    displayGhost() boardGhost();
}
else
{
	itemModule();
}

module boardGhost()
{
    boardStandoffZ = 2.5;

    difference()
    {
        translate([0,0,standoffZ]) union()
        {
            hull() doubleX() doubleY() translate([boardX/2-1, boardY/2-1, wallZ + boardStandoffZ]) cylinder(d=2, h=5.75);
            standoffsXform(z=wallZ) cylinder(d=3.5, h=boardStandoffZ);
        }
        
        standoffsXform(z=-10) cylinder(d=2, h=100);
    }
    
}
