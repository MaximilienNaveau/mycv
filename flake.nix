{
  description = "TeX Live + Biber shell for CV project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          (pkgs.texlive.combine {
            inherit (pkgs.texlive) 
              scheme-full
              biber
              latexmk
              collection-fontsrecommended;
          })
        ];
        shellHook = ''
          echo "TeX Live and Biber environment loaded via Nix Flake."
        '';
      };
    };
}
