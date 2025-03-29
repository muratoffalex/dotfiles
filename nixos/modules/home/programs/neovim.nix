{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      # lsp
      marksman
      lua-language-server
      intelephense
      gopls
      nil
      clang-tools
      typescript-language-server
      vue-language-server
      tailwindcss-language-server
      vscode-langservers-extracted # css,html,json,eslint
      pyright
      rust-analyzer
      # TODO: uncomment when accepted -- https://nixpkgs-tracker.ocfox.me/?pr=385105
      # kulala-ls

      # linters
      markdownlint-cli
      golangci-lint
      php.packages.php-codesniffer

      # formatters
      gotools # goimports inside
      stylua
      prettierd
      nodePackages.prettier
      nixfmt-rfc-style
      kulala-fmt
      libxml2 # xmllint

      # other
      mysql-client # for dadbod
      # for images/pdf/video in snacks.image
      imagemagick
      ghostscript_headless
      jellyfin-ffmpeg
    ];
  };
}
