{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.config.url = "github:ivandimitrov8080/configuration.nix";
  # nvim config helper
  inputs.nixvim.url = "github:nix-community/nixvim";
  inputs.nixvim.inputs.nixpkgs.follows = "nixpkgs";
  # neovim latest version
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  outputs =
    {
      self,
      nixpkgs,
      config,
      nixvim,
      neovim-nightly-overlay,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      nvim = (nixvim.legacyPackages.${system}.makeNixvim config.nixvimConfigs.default).extend {
        package = neovim-nightly-overlay.packages.${system}.default;
        plugins = {
          lsp.servers = {
            hls.enable = true;
            hls.installGhc = false;
          };
          haskell-scope-highlighting.enable = true;
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (ghc.withPackages (
            hkgs: with hkgs; [
              Euterpea
              tidal
            ]
          ))
          timidity
          nvim
        ];
      };
    };
}
