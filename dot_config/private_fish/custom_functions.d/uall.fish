function uall --description "Update all dependencies"
    bob update
    brew upgrade
    mas upgrade
    nvim --headless "+Lazy! sync" +qa
end
