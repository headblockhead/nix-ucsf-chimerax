{
  description = "ChimeraX is an application for visualizing and analyzing molecule structures such as proteins, RNA, DNA, lipids as well as gene sequences, electron microscopy maps, X-ray maps, 3D light microscopy and 3D medical imaging scans. It is the successor of the UCSF Chimera program.";
  # 22.05
  #inputs = { nixpkgs.url = "nixpkgs/72783a2d0dbbf030bff1537873dd5b85b3fb332f"; };
  # qt 6.3
  inputs = { nixpkgs.url = "nixpkgs/d529e6962d22d13e28439c67adbf1ef7381f7143"; };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      chimerax = pkgs.callPackage ./default.nix {};
    in {
      packages = {
        x86_64-linux = {
        default = chimerax;
      };
      };
      devShells = {
        x86_64-linux = {
        default = pkgs.mkShell {
          packages = [ chimerax ];
        };
      };
      };
    };
}
