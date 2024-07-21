{ inputs }:
let inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in buildVimPlugin {
      name = "clement";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/LICENSE
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/lib
      '';
      src = ../.;
    };

  mkNeovimPlugins = { system }:
    let
      inherit (pkgs) vimPlugins;
      pkgs = legacyPackages.${system};
      clement-nvim = mkVimPlugin { inherit system; };
    in [
      {
        plugin = pkgs.vimPlugins.sqlite-lua;
        config =
          "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.dylib'"; # macOS
      }
      clement-nvim
    ];

  mkExtraPackages = { system }:
    let
      inherit (pkgs) nodePackages python310Packages; # ocamlPackages
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in with pkgs; [
      # Utils:
      fzf
      xclip

      # Language Support:
      yarn
      php
      php83Packages.composer
      python311
      python311Packages.pip
      #cargo
      #luajitPackages.luarocks
      # pkgs.sqlite
      # pkgs.zulu

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

  mkExtraConfig = ''
    lua << EOF
      require("oui").init()
      require("oui.lazy")
    EOF
  '';

  mkNeovim = { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };
      extraMakeWrapperArgs =
        ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      # withRuby = true;
    };

  mkHomeManager = { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in {
      inherit extraConfig extraPackages plugins;
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      # withRuby = true;
    };
}
