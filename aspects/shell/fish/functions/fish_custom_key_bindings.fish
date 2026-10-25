function fish_custom_key_bindings
    fish_vi_key_bindings

    bind -m insert / fzf-history-widget
    bind -m insert ctrl-d fzf-cd-widget

    bind -M insert ctrl-s "fish_commandline_prepend sudo"
    bind ctrl-s "fish_commandline_prepend sudo"

    bind --preset -e -M insert alt-y alt-b alt-f alt-right alt-left alt-up alt-down alt-. alt-l alt-o alt-w
    bind --preset -e -M insert alt-d alt-s alt-h alt-p alt-e alt-v alt-# alt-enter
    bind --preset -e -M visual alt-y alt-b alt-f alt-right alt-left alt-up alt-down alt-. alt-l alt-o alt-w
    bind --preset -e -M visual alt-d alt-s alt-h alt-p alt-e alt-v alt-# alt-enter
    bind --preset -e alt-y alt-b alt-f alt-right alt-left alt-up alt-down alt-. alt-l alt-o alt-w
    bind --preset -e alt-d alt-s alt-h alt-p alt-e alt-v alt-# alt-enter ctrl-alt-r
    bind -e alt-c
    bind -e -M insert alt-c
end
