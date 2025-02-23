function tmp --argument name --description "Create directory in ~/tmp and run tmux session inside"
    set -l directory_path ~/tmp

    if string match -q -- "*.git" "$name"; or string match -q -- "git@*" "$name"
        set repo_name (basename $name .git)
        set directory_path ~/tmp/$repo_name

        git clone $name $directory_path
    else if test -n "$name"
        set directory_path ~/tmp/$name
        mkdir -p $directory_path
    else
        mkdir -p $directory_path
    end

    cd $directory_path
    sesh connect $directory_path
end
