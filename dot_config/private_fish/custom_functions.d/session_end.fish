function session_end --description "Clean up session and kill tmux server"
    ~/scripts/session_cleanup
    tmux kill-server
end
