{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    # HACK: for nvim snacks.picker for frecency and history
    SQLITE_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}";
  };

  xdg.configFile."nvim/init.lua" = {
    enable = lib.mkForce false; # forces disabling the creation of init.lua
  };

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraPackages = with pkgs; [
      tree-sitter

      # for codecompanion
      file

      # lsp
      marksman
      lua-language-server
      intelephense
      gopls
      nil
      clang-tools
      typescript-language-server
      # vue-language-server # pnpm vulnerability, uncomment later
      tailwindcss-language-server
      vscode-langservers-extracted # css,html,json,eslint
      pyright
      rust-analyzer
      protobuf-language-server

      # linters
      markdownlint-cli
      golangci-lint
      php.packages.php-codesniffer

      # formatters
      gotools # goimports inside
      stylua
      prettierd
      prettier
      nixfmt
      kulala-fmt
      libxml2 # xmllint

      # dadbod clients
      mariadb.client
      postgresql
      sqlite

      # for images/pdf/video in snacks.image
      imagemagick
      ghostscript_headless
      jellyfin-ffmpeg
    ];
  };
}
