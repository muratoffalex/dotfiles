function zadd --argument path --description "Add all directories in the given directory to zoxide"
    set -q path; or set path "*/"
    ls -d $path | xargs -I {} zoxide add {}
end
