function get_theme
    cat $HOME/.cache/settings/theme 2>/dev/null || echo "dark"
end
