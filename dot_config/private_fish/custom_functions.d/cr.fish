function cr --argument name dir_name --description "Create or enter directory and start tmux session"
    set -l base_dir $DEV_PATH

    if test -z "$name"
        echo "Usage: cr <name|git_url> [directory]"
        return 1
    end

    if test -z "$dir_name"
        set dir_name "tmp"
    end

    set -l target_dir $base_dir/$dir_name

    mkdir -p $target_dir

    if string match -q -- "*.git" "$name"; or string match -q -- "git@*" "$name"
        set repo_name (basename $name .git)
        set final_path $target_dir/$repo_name

        if not test -d $final_path
            git clone $name $final_path
        end
    else
        set final_path $target_dir/$name
        if not test -d $final_path
            mkdir -p $final_path
        end
    end

    cd $final_path
    sesh connect $final_path
end
