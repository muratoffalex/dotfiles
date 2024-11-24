if type -q fzf
    function fdp --description "Fuzzy find with preview"
        fzf --preview 'bat --style=numbers --color=always {}'
    end
end
