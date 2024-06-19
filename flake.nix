{
  description = "My Neovim config Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.neovim-nightly-overlay.url =
    "github:nix-community/neovim-nightly-overlay";

  outputs = inputs@{ self, nixpkgs, neovim-nightly-overlay, ... }: {
    packages = let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      extraPackages = with pkgs; [
        # Utils:
        fzf
        xclip

        # Language Support:
        yarn
        php
        php83Packages.composer
        python311
        python311Packages.pip

        # LSP:
        clang-tools # for clangd
        lua-language-server
        nixd
        vscode-langservers-extracted
        emmet-language-server
        ruff-lsp
        nodePackages.volar
        nodePackages.typescript-language-server

        # Format:
        nixfmt
        prettierd
        stylua
        isort
        black
        shfmt
      ];
    in {
      x86_64-linux.default = pkgs.neovim.override {
        configure = {
          viAlias = true;
          customRC = ''
            lua << EOF
            require("oui").init()
            require("oui.lazy")
            EOF
          '';
        };
        extraMakeWrapperArgs =
          ''--suffix PATH : "${pkgs.lib.strings.makeBinPath extraPackages}"'';
      };
    };
  };
}
