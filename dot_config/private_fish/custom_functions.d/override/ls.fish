if type -q eza
    function ls --wraps eza --description 'eza wrapper'
        eza --smart-group --icons auto --group-directories-first $argv
    end
end
