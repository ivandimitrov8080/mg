{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    ide = {
      url = "github:ivandimitrov8080/flake-ide";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ide, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            nvim = ide.nvim.${system}.standalone {
              plugins = {
                lsp.servers = {
                  hls.enable = true;
                };
              };
            };
          })
        ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (ghc.withPackages (hkgs: with hkgs; [ Euterpea ]))
          timidity
          nvim
        ];
      };
    };
}
