{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

  inputs.tolerable.url = "github:wires-org/tolerable-nvim-nix";
  inputs.tolerable.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";
  inputs.tolerable.inputs.nightly.follows = "nightly";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: {
      neovim = inputs.tolerable.makeNightlyNeovimConfig "nixconfig" {
        inherit pkgs;
        src = pkgs.lib.fileset.toSource {
          root = ./.;
          fileset = ./nixconfig;
        };
         config = {
	  extraPackages = with pkgs; [

            # Utils:
            fzf
            xclip
            tree-sitter

            # Language Support:
            yarn
            php
            php83Packages.composer
            python311
            python311Packages.pip
            go
            gotools # goimports

            # LSP:
            clang-tools # for clangd
            cmake-language-server
            lua-language-server
            nixd
            vscode-langservers-extracted
            emmet-language-server
            ruff-lsp
            pyright
            vscode-extensions.vue.volar
            nodePackages.typescript-language-server
            nodePackages.intelephense
            tailwindcss-language-server
            bash-language-server
            gopls
            # npm install -g @vtsls/language-server
            # npm install -g vscode-langservers-extracted

            # Lint:
            # cmake-lint
            hadolint
            php83Packages.php-codesniffer # PHPCS
            golangci-lint

            # Format:
            nixfmt-rfc-style
            prettierd
            cmake-format
            stylua
            isort
            black
            shfmt
            gofumpt

            # DAP:
            delve

            # Misc:
            gomodifytags
            impl
	  ];
        };
      };
    });
  };
}
