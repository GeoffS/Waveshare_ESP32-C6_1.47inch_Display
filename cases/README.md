# 3D-Printable Case Designs

All [OpenSCAD](https://openscad.org/) designs require a copy of the [`OpenSCAD_Lib`](https://github.com/GeoffS/OpenSCAD_Lib) project to be available next to (i.e. at the same level)
as the `Waveshare_ESP32-C6-_.47inch_Display` directory.

You wil likely need to supply the path to your `openscad.exe` file via the `-osc` parameter to `makeStls.py` script (see `python makeStls.py --help` for a full list of options).

## basic_case.scad
An OpenSCAD design for a simple case to provide some basic protection for the board.

To make the STL file: `python ../../OpenSCAD_Lib\makeStls.py .\basic_case.scad`