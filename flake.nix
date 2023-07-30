{
    description = "Custom dwm build";

    inputs.nixpkgs.url = "github:nixos/nixpkgs";

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        packages.${system} = {
            dwm-package = pkgs.dwm.overrideAttrs (_: {
                version = "main";
                src = ./.;
                patches = [ ];
            });
            default = self.packages.${system}.dwm-package;
        };
    };
}
