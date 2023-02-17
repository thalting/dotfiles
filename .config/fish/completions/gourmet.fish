# Completion for gourmet https://github.com/thalting/gourmet

function __fish_complete_gourmet_subcommand
    set -lx -a PATH /usr/local/sbin /sbin /usr/sbin
    __fish_complete_subcommand --commandline $args
end

# Complete the command we are executing under gourmet
complete -c gourmet -x -a "(__fish_complete_gourmet_subcommand)"
