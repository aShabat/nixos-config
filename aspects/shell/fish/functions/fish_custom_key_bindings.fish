function fish_custom_key_bindings
    fish_vi_key_bindings

    bind -m insert / fzf-history-widget
    bind -m insert \cd fzf-cd-widget
end
