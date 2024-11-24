# create directory and move onto it
function mkcd --description "Create directory and move onto it"
    mkdir -p $argv[1]
    cd $argv[1]
end
