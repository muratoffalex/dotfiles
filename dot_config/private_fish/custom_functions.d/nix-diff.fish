function nix-diff
    set -l old_system
    set -l new_system

    if test (count $argv) -eq 0
        set old_system (command ls -d /nix/var/nix/profiles/system-*-link | sort -V | tail -n2 | head -n1)
        set new_system (command ls -d /nix/var/nix/profiles/system-*-link | sort -V | tail -n1)
    else if test (count $argv) -eq 2
        set -l ver1 $argv[1]
        set -l ver2 $argv[2]

        set old_system "/nix/var/nix/profiles/system-$ver1-link"
        set new_system "/nix/var/nix/profiles/system-$ver2-link"

        if not test -e "$old_system"
            echo "error: $old_system does not exist" >&2
            return 1
        end
        if not test -e "$new_system"
            echo "error: $new_system does not exist" >&2
            return 1
        end
    else
        echo "Usage: nix-diff [version1 version2]" >&2
        return 1
    end

    echo "=== System changes: $(basename $old_system) → $(basename $new_system) ==="
    nix store diff-closures $old_system $new_system
end
