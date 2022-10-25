{ pkgs, stdenv, dpkg, glibc, gcc-unwrapped, autoPatchelfHook }:
let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "rc";

  src = fetchurl {
    url = "https://www.cgl.ucsf.edu/chimerax/cgi-bin/secure/chimerax-get.py?ident=OHeQer2fSLp7%2BfxtoHxc5%2Flkr0FSQ9j%2B3ht23gv5ifI%3D&file=current%2Fubuntu-22.04%2Fchimerax-rc.deb&choice=Notified";
    sha256 = "4EDZHiXJGv3KMQCF9EyC73Zwl28fTS29y6IEroD+c4k=";
  };
  
  libnsl = stdenv.mkDerivation rec {
    pname = "libnsl";
    version = "1.3.0";
    src = pkgs.fetchFromGitHub {
      owner = "thkukuk";
      repo = pname;
      rev = "v${version}";
      sha256 = "1dayj5i4bh65gn7zkciacnwv2a0ghm6nn58d78rsi4zby4lyj5w5";
    };

    nativeBuildInputs = [ pkgs.autoreconfHook pkgs.pkg-config ];
    buildInputs = [ pkgs.libtirpc ];
  };
  my-python-packages = python-packages: with python-packages; [
    webencodings
  ];
  python-with-my-packages = pkgs.python39.withPackages my-python-packages;
in
stdenv.mkDerivation rec {
  name = "chimerax-${version}";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    pkgs.addOpenGLRunpath
    pkgs.cudaPackages.autoAddOpenGLRunpathHook
    pkgs.qt6.wrapQtAppsHook
    dpkg
  ];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
    pkgs.linuxKernel.packages.linux_5_19.nvidia_x11
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
    pkgs.libtirpc
    libnsl
    pkgs.opencl-clang
    pkgs.opencl-headers
    pkgs.rocm-opencl-runtime
    pkgs.opencl-clhpp
    pkgs.conda
    pkgs.vial
    pkgs.mysql80
    pkgs.cudaPackages.cudatoolkit
    pkgs.openssl_3
    python-with-my-packages
  ];
  propagatedBuildInputs = buildInputs;
  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/usr/* $out
    rm -rf $out/usr
  '';

  # meta = with stdenv.lib; {
  #   description = "ChimeraX";
  #   homepage = https://www.cgl.ucsf.edu/chimerax/;
  #   license = licenses.mit;
  #   maintainers = with stdenv.lib.maintainers; [ ];
  #   platforms = [ "x86_64-linux" ];
  # };
}
