# ref: https://github.com/sigoden/aichat/blob/main/scripts/shell-integration/integration.fish
function _aichat
    set -l _old (commandline)
    if test -n $_old
        echo -n "⌛"
        commandline -f repaint
        commandline (aichat -e $_old)
    end
end
