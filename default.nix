{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];
  perSystem =
    { system, pkgs, ... }:
    {
      config = {
        _module.args = {
          pkgs = import inputs.configuration.inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.configuration.overlays.default ];
          };
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (ghc.withPackages (
              hkgs: with hkgs; [
                Euterpea
              ]
            ))
            (nvim.extend {
              plugins = {
                lsp.servers = {
                  hls = {
                    enable = true;
                    installGhc = false;
                  };
                };
              };
            })
            timidity
          ];
        };
        packages.default = pkgs.stdenv.mkDerivation { };
      };
    };
}
