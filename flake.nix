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
      vim-tidal = pkgs.vimUtils.buildVimPlugin {
        name = "vim-tidal";
        src = pkgs.fetchFromGitHub {
          owner = "tidalcycles";
          repo = "vim-tidal";
          rev = "e440fe5bdfe07f805e21e6872099685d38e8b761";
          sha256 = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
        };
      };
      nvim = (nixvim.legacyPackages.${system}.makeNixvim config.nixvimConfigs.default).extend {
        package = neovim-nightly-overlay.packages.${system}.default;
        keymaps = [
          {
            mode = [
              "n"
              "v"
            ];
            key = "<leader>th";
            action = "<cmd>TidalHush<cr>";
            options = {
              desc = "Hush tidal";
            };
          }
          {
            mode = [
              "n"
              "v"
            ];
            key = "<leader>ts";
            action = ":TidalSend<cr>";
            options = {
              desc = "Send to tidal";
            };
          }
        ];
        plugins = {
          auto-session.enable = pkgs.lib.mkForce false;
          lsp.servers = {
            hls.enable = true;
            hls.installGhc = false;
          };
          haskell-scope-highlighting.enable = true;
        };
        extraPlugins = [ vim-tidal ];
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
          supercollider-with-plugins
          timidity
          nvim
        ];
      };
    };
}
