{
  description = "ChimeraX is an application for visualizing and analyzing molecule structures such as proteins, RNA, DNA, lipids as well as gene sequences, electron microscopy maps, X-ray maps, 3D light microscopy and 3D medical imaging scans. It is the successor of the UCSF Chimera program.";
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      chimerax = pkgs.callPackage ./chimerax.nix {};
    in {
      devShells = {
        x86_64-linux = {
        default = pkgs.mkShell {
          packages = [ chimerax ];
        };
      };
      };
    };
}
