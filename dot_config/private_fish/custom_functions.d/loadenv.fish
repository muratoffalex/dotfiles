function loadenv
    if test -f .env
        set loaded_count 0
        set skipped_count 0

        while read -l line
            set line (string trim -- $line)

            # Skip comments and empty lines
            if test -z "$line" || string match -qr '^#' -- $line
                continue
            end

            # Split into name and value
            set parts (string split -m 1 '=' -- $line)
            if test (count $parts) -eq 2
                set var_name $parts[1]
                set var_value $parts[2]

                if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*$' -- $var_name
                    echo "Warning: Skipping invalid variable name: $var_name"
                    set skipped_count (math $skipped_count + 1)
                    continue
                end

                # Remove quotes from the beginning and end, if they exist
                if string match -qr '^["'']' -- $var_value
                    and string match -qr '["'']$' -- $var_value
                    set var_value (string sub -s 2 -e -1 -- $var_value)
                end

                set -gx $var_name $var_value
                set loaded_count (math $loaded_count + 1)
            else
                echo "Warning: Skipping invalid line: $line"
                set skipped_count (math $skipped_count + 1)
            end
        end < .env
        if test $skipped_count -gt 0
            echo "Loaded $loaded_count variables from .env ($skipped_count skipped)"
        else
            echo "Loaded $loaded_count variables from .env"
        end
    else
        echo "No .env file found"
    end
end
