# {
#     description = "Custom dwm build";
#
#     inputs.nixpkgs.url = "github:nixos/nixpkgs";
#
#     outputs = { self, nixpkgs, ... }:
#     let
#         system = "x86_64-linux";
#         pkgs = import nixpkgs { inherit system; };
#     in {
#         packages.${system} = {
#             dwm-package = pkgs.dwm.overrideAttrs (_: {
#                 version = "main";
#                 src = ./.;
#                 patches = [ ];
#             });
#             default = self.packages.${system}.dwm-package;
#         };
#     };
# }

{
  description = "Custom build of dwm";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "dwm";
        pkgs = nixpkgs.legacyPackages.${system};
        package = pkgs.dwm.overrideAttrs (_: {
          version = "master";
          src = ./.;
          patches = [ ];
        });
      in
      rec {
        apps = { ${name} = { type = "app"; program = "${defaultPackage}/bin/${name}"; }; };
        defaultPackage = package;
        packages.${name} = defaultPackage;
        defaultApp = apps.${name};
      }
    );
}
