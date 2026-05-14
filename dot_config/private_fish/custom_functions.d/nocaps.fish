function nocaps --description 'Run a program with all capabilities dropped'
    setpriv --inh-caps=-all --ambient-caps=-all $argv
end
