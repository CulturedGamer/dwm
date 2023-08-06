{
    description = "Basic flake for a custom dwm build";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                name = "dwm";
                package  = pkgs.${name};
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [
                        (final: prev: {
                            ${name} = prev.dwm.overrideAttrs (oldAttrs: {
                                version = "main";
                                src = ./.;
                            });
                        })
                    ];
                };
            in {
                apps = {
                    dwm = {
                        type = "app";
                        program = "${package}/bin/${name}";
                    };
                    default = self.apps.dwm;
                };
                packages = {
                    default = package;
                };
            }
        );
}
