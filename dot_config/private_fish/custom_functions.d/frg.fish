if type -q rg
  function frg --description 'rg and open in fzf, then open in vim'
    rg $argv | fzf | cut -d':' -f 1 | xargs -n 1 nvim
  end
end
