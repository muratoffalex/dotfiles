if command -q nix-shell
    function nix-shell --wraps nix-shell --description 'nix-shell with fish as default shell'
        command nix-shell --run fish $argv
    end
end
