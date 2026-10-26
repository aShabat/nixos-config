if type -q fzf
    set -gx FZF_DEFAULT_COMMAND "fd --strip-cwd-prefix"
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND
    fzf --fish | source
end
