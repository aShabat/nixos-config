if status is-interactive
    and not set -q TMUX
    and not set -q NO_TMUX
    and type -q tmux
    exec tmux
end
