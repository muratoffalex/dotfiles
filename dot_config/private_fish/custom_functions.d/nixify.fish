function nixify
    if test ! -e ./.envrc
        echo "use nix" > .envrc
        direnv allow
    end

    if test ! -e shell.nix; and test ! -e default.nix
        echo 'with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}' > default.nix
    end
end
