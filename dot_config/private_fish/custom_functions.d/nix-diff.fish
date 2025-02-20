function nix-diff
    echo "=== System changes ==="
    nix store diff-closures $(ls -d /nix/var/nix/profiles/system-*-link | sort -V | tail -n2)
    echo -e "\n=== Home Manager changes ==="
    nix store diff-closures $(ls -d ~/.local/state/nix/profiles/home-manager* | sort -V | tail -n2)
end
