#!/bin/bash

PATH=$PATH:/mnt/c/MSFStk

case "$1" in
    cleanonly)
	rm -rfv Temp Output
	exit
	;;
    clean*)
	rm -rfv Temp Output
	;;
esac

# msfs project -type scenery -id EDAP -name "charliebravo-airport-edap-cottbus-neuhausen" -title "Verkehrslandeplatz Cottbus-Neuhausen" -creator charliebravo -version 0.1.1 -aerial -scene -mesh -services EDAP "edap"

# mesh: airfield premises in 5m
powershell.exe msfs elev -border '.\Sources\edap-premises.shp' \
	       -imagery '.\Sources\dem\dgm-edap.tif' \
	       -res 5 -falloff 50 -priority 2 \
	       'PackageSources\mesh\mesh-edap.xml'

# mesh: details in 1m
powershell.exe msfs elev -border '.\Sources\edap-rwy11L.shp' \
	       -imagery '.\Sources\dem\dgm-edap.tif' \
	       -res 1 -falloff 50 -priority 3 \
	       -airport 'PackageSources\scene\EDAP.xml' \
	       'PackageSources\mesh\mesh-edap-rwy11L.xml'
powershell.exe msfs elev -border '.\Sources\edap-fuel.shp' \
	       -imagery '.\Sources\dem\dgm-edap.tif' \
	       -res 1 -falloff 5 -priority 3 \
	       'PackageSources\mesh\mesh-edap-fuel.xml'

fspackagetool.exe -mirroring -nopause '.\charliebravo-airport-edap-cottbus-neuhausen.xml'
