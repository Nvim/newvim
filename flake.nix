{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

  inputs.tolerable.url = "github:wires-org/tolerable-nvim-nix";
  inputs.tolerable.inputs.nixpkgs.follows = "nixpkgs";
  inputs.tolerable.inputs.nightly.follows = "nightly";

  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";

  inputs.flake-parts = {
    url = "github:hercules-ci/flake-parts";
    inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        systems = [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        perSystem =
          {
            inputs',
            system,
            config,
            lib,
            pkgs,
            ...

          }:
          {

            packages = {
              neovim =
                (inputs.tolerable.makeNightlyNeovimConfig "nixconfig" {
                  inherit pkgs;
                  src = pkgs.lib.fileset.toSource {
                    root = ./.;
                    fileset = ./nixconfig;
                  };
                  config = {
                    plugins = [ ];
                  };
                }).overrideAttrs
                  (old: {
                    generatedWrapperArgs =
                      with pkgs;
                      old.generatedWrapperArgs or [ ]
                      ++ [
                        "--prefix"
                        "PATH"
                        ":"
                        (lib.makeBinPath [

                          # Utils:
                          fzf
                          xclip
                          tree-sitter

                          # Language Support:
                          # yarn
                          # php
                          # php83Packages.composer
                          python312
                          python312Packages.pip
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
                          # nodePackages.intelephense
                          tailwindcss-language-server
                          bash-language-server
                          gopls
                          sqls
                          # npm install -g @vtsls/language-server
                          # npm install -g vscode-langservers-extracted

                          # Lint:
                          cmake-lint
                          hadolint
                          # php83Packages.php-codesniffer # PHPCS
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

                        ])
                      ];
                  });
              default = config.packages.neovim;
            };
          };
        flake =
          let

            package = inputs.nixpkgs.lib.genAttrs config.systems (
              system: inputs.self.packages.${system}.default
            );
          in
          {
            defaultPackage = package;
          };
      }
    );
}
