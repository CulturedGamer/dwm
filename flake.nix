{
    description = "Custom dwm build";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [
                        (final: prev: {
                            dwm-custom = prev.dwm.overrideAttrs (oldAttrs: {
                                version = "main";
                                src = ./.;
                            });
                        })
                    ];
                };
            in rec {
                apps = {
                    dwm = {
                        type = "app";
                        program = "${defaultPackage}/bin/st";
                    };
                };

                packages.dwm-custom = pkgs.dwm-custom;
                defaultApp = apps.dwm;
                defaultPackage = pkgs.dwm-custom;
            }
        );
}
