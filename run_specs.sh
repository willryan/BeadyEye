#!/bin/sh

booi -r:$BOO_SPEC_HOME/Dll/BooSpec.dll -r:Dll/BeadyEye.dll -r:Dll/BeadyEyeSpecs.dll $BOO_SPEC_HOME/Exec/BooSpecMain.boo "$@"

