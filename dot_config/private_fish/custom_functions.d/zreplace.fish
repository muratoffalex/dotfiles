function zreplace --description "Replace paths in zoxide database and current directory that match a pattern" --argument-names old new
    if test (count $argv) -ne 2
        echo "Usage: zreplace <old-pattern> <new-pattern>"
        return 1
    end

    set -l old_pattern $old
    set -l new_pattern $new

    echo "Debug: Old='$old_pattern', New='$new_pattern'"

    # Get all paths from zoxide database
    for path in (zoxide query -l)
        if string match -q "*$old_pattern*" $path
            echo "Debug: Found matching path: $path"
            set -l new_path (string replace $old_pattern $new_pattern $path)
            echo "Debug: Removing: $path"
            zoxide remove $path
            echo "Debug: Adding: $new_path"
            zoxide add $new_path
        end
    end
end
