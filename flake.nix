{
    description = "Custom build of dwm";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        packages.${system} = {
            dwm-custom = pkgs.dwm.overrideAttrs(_: {
                version = "master";
                src = ./.;
                patches = [ ];
            });
            default = self.packages.${system}.dwm-custom;
        };
    };
}
