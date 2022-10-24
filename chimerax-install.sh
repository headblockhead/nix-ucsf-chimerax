# Create the standard environment.
source $stdenv/setup
# Untar the source
mkdir -p $out/opt
tar -C $out/opt -xzf $src
# Create place to store the binaries.
mkdir -p $out/bin
# Make symlinks to the binaries.
ln -s $out/opt/chimerax-1.4/bin/ChimeraX $out/bin/ChimeraX
# Remove some of the plugins that cannot have their libraries satisfied.
#rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMOpenCL.so
#rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMRPMDOpenCL.so
#rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMDrudeOpenCL.so
#rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMAmoebaOpenCL.so

rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMCUDA.so
rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMRPMDCUDA.so
rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMDrudeCUDA.so
rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMCudaCompiler.so
rm -r $out/opt/chimerax-1.4/lib/plugins/libOpenMMAmoebaCUDA.so

rm -r $out/opt/chimerax-1.4/lib/python3.9/lib-dynload/_ctypes.cpython-39-x86_64-linux-gnu.so
