{
    description = "Description for the project";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = inputs@{ flake-parts, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {
            imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
            systems = [ "x86_64-linux" ];
            perSystem = { config, pkgs, system, ... }: {
                packages = {
                    dwm = pkgs.dwm.overrideAttrs (oldAttrs: {
                        version = "main";
                        src = ./.;
                    });
                };
                overlayAttrs = {
                    inherit (config.packages)
                        dwm;
                };
            };
        };
}
