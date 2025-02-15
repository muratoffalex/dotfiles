function tmp --argument name --description "Create directory in ~/tmp and run tmux session inside"
    set -l directory_path ~/tmp
    if test -n "$name"
        set directory_path ~/tmp/$name
    end
    mkdir -p $directory_path
    cd $directory_path
    sesh connect $directory_path
end
