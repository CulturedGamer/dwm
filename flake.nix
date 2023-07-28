{
    description = "My build of dwm";

    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system: {
            
        });
}
