function __nocaps_complete
    set -l cmdline (commandline --tokenize)
    if test (count $cmdline) -le 1
        __fish_complete_command
    else
        __fish_complete_subcommand --commandline $cmdline --fcs-skip=1
    end
end

complete --command nocaps --no-files --arguments '(__nocaps_complete)'
