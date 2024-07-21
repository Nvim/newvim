{
  description = "My Neovim config Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  outputs =
    inputs@{
      self,
      nixpkgs,
      neovim-nightly-overlay,
      ...
    }:
    {
      packages =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          # Vim plugin that provides all my config so I can require it
          mkVimPlugin =
            { }:
            let
              inherit (pkgs) vimUtils;
              inherit (vimUtils) buildVimPlugin;
              pkgs = inputs.nixpkgs.legacyPackages.${system};
            in
            buildVimPlugin {
              name = "oui";
              postInstall = ''
                rm -rf $out/.gitignore
                rm -rf $out/lib
                rm -rf $out/flake.nix
                rm -rf $out/flake.lock
              '';
              src = ./.;
            };

          # Hard-coded neovim plugins (my config as a plugin)
          mkNeovimPlugins =
            { }:
            let
              # inherit (pkgs) vimPlugins; # in case i need to add more hard-coded plugins
              my-nvim = mkVimPlugin { };
            in
            [ my-nvim ];

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

            # LSP:
            clang-tools # for clangd
            cmake-language-server
            lua-language-server
            nixd
            vscode-langservers-extracted
            emmet-language-server
            ruff-lsp
            vscode-extensions.vue.volar
            nodePackages.typescript-language-server
            # npm install -g @vtsls/language-server
            bash-language-server

            # Lint:
            cmake-lint
            hadolint
            php83Packages.php-codesniffer # PHPCS

            # Format:
            nixfmt-rfc-style
            prettierd
            cmake-format
            stylua
            isort
            black
            shfmt

            # DAP:
            vscode-extensions.vadimcn.vscode-lldb
          ];

          extraConfig = ''
            lua << EOF
              require("oui").init()
              require("oui.lazy")
            EOF
          '';
        in
        {
          x86_64-linux.default =
            let
              start = mkNeovimPlugins { };
            in
            pkgs.neovim.override {
              configure = {
                viAlias = true;
                customRC = extraConfig;
                packages.main = {
                  inherit start;
                };
              };
              extraMakeWrapperArgs = ''--suffix PATH : "${pkgs.lib.strings.makeBinPath extraPackages}"'';
              withNodeJs = true;
              withPython3 = true;
            };
        };
    };
}
