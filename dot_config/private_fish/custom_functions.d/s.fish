function s --description "Open sesh with gum"
    set -l session
    set session (sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
    if test -z "$session"
        return
    end
    sesh connect $session
end
