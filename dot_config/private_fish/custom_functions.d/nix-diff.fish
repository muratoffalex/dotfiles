function nix-diff
    set -l old_system (ls -d /nix/var/nix/profiles/system-*-link | sort -V | tail -n2 | head -n1)
    set -l new_system (ls -d /nix/var/nix/profiles/system-*-link | sort -V | tail -n1)
    set -l old_home (ls -d ~/.local/state/nix/profiles/home-manager* | sort -V | tail -n2 | head -n1)
    set -l new_home (ls -d ~/.local/state/nix/profiles/home-manager* | sort -V | tail -n1)

    echo "=== System changes: $(basename $old_system) → $(basename $new_system) ==="
    nix store diff-closures $old_system $new_system

    echo -e "\n=== Home Manager changes: $(basename $old_home) → $(basename $new_home) ==="
    nix store diff-closures $old_home $new_home
end
