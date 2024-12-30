# force TERM to screen-256color
# because some servers do not support modern terminals (alacritty, xterm-ghostty etc.)
function ssh
    env TERM=screen-256color command ssh $argv
end
