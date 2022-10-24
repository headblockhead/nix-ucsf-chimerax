{ pkgs, stdenv, fetchurl, autoPatchelfHook }:

let 
  my-python-packages = python-packages: with python-packages; [
    webencodings
  ]; 
  python-with-my-packages = pkgs.python39.withPackages my-python-packages;
in
stdenv.mkDerivation {
  pname = "chimerax";
  version = "1.4";
  src = fetchurl {
#    url =
#      "https://www.cgl.ucsf.edu/chimerax/cgi-bin/secure/chimerax-get.py?ident=OHeQer2fSLp7%2BfxtoHxc5%2Flkr0FSQ9j90xJ03g75hA%3D%3D&file=1.4%2Flinux%2FChimeraX-1.4.tar.gz&choice=Notified";
    url =
      "https://www.rbvi.ucsf.edu/chimerax/cgi-bin/secure/chimerax-get.py?ident=OHeQer2fSLp7%2BfxtoHxc5%2Flkr0FSQ9j%2B0xtz0gr5gvM%3D&file=1.4%2Flinux%2FChimeraX-1.4.tar.gz&choice=Notified";
    sha256 = "00JVND2G+46IkjApDs837C2kLxLV9IZATCDE3mNRfIc=";
  };
  buildInputs = [
    pkgs.libffi
          pkgs.qt6.wrapQtAppsHook
          pkgs.glib
          pkgs.gdk-pixbuf
          pkgs.cairo
          pkgs.pango
          pkgs.udev
          pkgs.alsa-lib
          pkgs.gtk3
          pkgs.webkitgtk
          pkgs.pkg-config
          pkgs.xorg.libX11
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.gcc-unwrapped
          pkgs.ffmpeg 
          pkgs.qt4
          pkgs.qt6.qt3d
          pkgs.qt6.qtquick3d
          pkgs.qt6.qtwebview
          pkgs.opencl-info
          pkgs.ncurses
          pkgs.opencl-clang
          pkgs.opencl-headers
          pkgs.rocm-opencl-runtime
          pkgs.opencl-clhpp
          pkgs.conda
          pkgs.vial
          pkgs.mysql80
          python-with-my-packages
        ];
        propagatedBuildInputs = [
          pkgs.libffi
           pkgs.qt6.wrapQtAppsHook
          pkgs.glib
          pkgs.gdk-pixbuf
          pkgs.cairo
          pkgs.pango
          pkgs.udev
          pkgs.alsa-lib
          pkgs.gtk3
          pkgs.webkitgtk
          pkgs.pkg-config
          pkgs.xorg.libX11
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.gcc-unwrapped
          pkgs.ffmpeg 
          pkgs.qt4
          pkgs.qt6.qt3d
          pkgs.qt6.qtquick3d
          pkgs.qt6.qtwebview
          pkgs.opencl-info
          pkgs.ncurses
          pkgs.opencl-clang
          pkgs.opencl-headers
          pkgs.rocm-opencl-runtime
          pkgs.opencl-clhpp
          pkgs.conda
          pkgs.vial
          pkgs.mysql80
          python-with-my-packages       
        ];
  nativeBuildInputs = [ autoPatchelfHook ];
  installPhase = ./chimerax-install.sh;
  system = builtins.currentSystem;
}
