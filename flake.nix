{
  description = "testing123";
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
