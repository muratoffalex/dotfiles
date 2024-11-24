function unpack --description "Extract archive file" --argument-names src dst
    if test -z "$src"
        echo "Usage: unpack <archive_file> [destination_directory]"
        return 1
    end

    # Create and cd to destination directory if specified
    if test -n "$dst"
        mkcd "$dst"
    end

    switch $src
        case '*.tar.gz' '*.tgz' '*.tar'
            tar -xf "$src"
        case '*'
            echo "Unsupported archive format: $src"
            return 1
    end
end
